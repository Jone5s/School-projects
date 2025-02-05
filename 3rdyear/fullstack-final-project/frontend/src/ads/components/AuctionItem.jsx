import { useContext, useState, useEffect } from 'react';
import { useMutation, useQueryClient } from 'react-query';
import Card from '../../shared/components/Card';
import Button from '../../shared/components/Button';
import { AuthContext } from '../../shared/context/auth-context';
import Modal from '../../shared/components/Modal';
import { deleteAuction, bidAuction } from '../api/cars';

import './AuctionItem.css';

const AuctionItem = props => {
  
  // Use context to access authentication-related data
  const auth = useContext(AuthContext);

  // Local state for managing modal visibility
  const [showConfirmationModal, setShowConfirmationModal] = useState(false);
  const [showDetailsModal, setShowDetailsModal] = useState(false);

  // State for handling the bidding functionality
  const [bidPrice, setBidPrice] = useState('');
  // State to manage countdown of time until the auction ends
  const [timeRemaining, setTimeRemaining] = useState('');

  // Hook to access React Query's query client
  const queryClient = useQueryClient();

  // Handlers for showing and hiding the confirmation modal
  const showConfirmationHandler = () => setShowConfirmationModal(true);
  const cancelConfirmationHandler = () => setShowConfirmationModal(false);

  // Convert end_time from props to a Date object
  const endTime = new Date(props.end_time);

  // Function to update the countdown timer
  const updateCountdown = () => {
    const now = new Date();
    const diff = endTime - now;

    if (diff <= 0) {
        setTimeRemaining('Auction ended');
    } else {
        const days = Math.floor(diff / (1000 * 60 * 60 * 24));
        const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
        setTimeRemaining(`${days}d ${hours}h ${minutes}m`);
    }
  };

  // Effect hook to set up a timer that updates every second
  useEffect(() => {
    const timerId = setInterval(updateCountdown, 1000);
    return () => clearInterval(timerId);
  }, [endTime]);

  // Setup mutation with React Query for deleting an auction
  const deleteCarMutation = useMutation({
    mutationFn: deleteAuction,
    onSuccess: (data) => {
      console.log(data);
      alert('The ad was successfully deleted!');
      queryClient.invalidateQueries('auctions');
    },
    onError: (error) => {
      console.error(error);
    }
  });

  // Handler for confirming the deletion of an auction
  const deleteConfirmedHandler = () => {
    setShowConfirmationModal(false);
    deleteCarMutation.mutate({
      id: props.id,
      token: auth.token
    });
  };

  // Function to handle bid submissions
  const handleBidSubmit = async () => {
    if (!bidPrice) {
        alert('Please enter a valid bid amount.');
        return;
    }
    if (parseInt(bidPrice) <= props.price) {
        alert('Bid must be larger than the current price.');
        return;
    }

    try {
        await bidAuction({
            id: props.id,
            highestBid: bidPrice,
            token: auth.token
        });
        alert('Your bid was successfully placed!');
    } catch (error) {
        console.error('Error submitting bid:', error);
        alert('Failed to place bid. Please try again.');
    }

    // Reset the bid price after submission
    setBidPrice('');
  };

  // JSX to render the component
  return (
    <>
      <Modal
        show={showConfirmationModal}
        header="Are you sure?"
        footerClass="auction-item__modal-actions"
        footer={
          <>
            <Button inverse onClick={cancelConfirmationHandler}>Cancel</Button>
            <Button danger onClick={deleteConfirmedHandler}>Delete</Button>
          </>
        }
      >
        <p>Are you sure you want to delete this auction?</p>
      </Modal>
      <Modal
        show={showDetailsModal}
        onCancel={() => setShowDetailsModal(false)}
        header="Auction Details"
        headerClass="auction-item__modal-header"
        contentClass="auction-item__modal-content"
        footerClass="auction-item__modal-actions"
        footer={<Button onClick={() => setShowDetailsModal(false)}>Close</Button>}
      >
        <div className='auction-item__details'>
          <img src={props.image} alt={props.make + ' ' + props.model} />
          <h3>{props.make} {props.model}</h3>
          <p>{props.description}</p>
          <h4>Current Bid: ${props.price}</h4>
          <p>Time Remaining: {timeRemaining}</p>
          <p>Horsepower: {props.hp}</p>
          <p>Fuel-type: {props.fueltype}</p>
          <p>Displacement: {props.displacement}</p>
        </div>
      </Modal>
      <li className='auction-item'>
      {auth.userId === props.creatorId && (
        <h2>Your auction</h2>
      )}
        {props.deleted ? null : (
          <Card className='auction-item__content'>
            <div className='auction-item__image'>
              <img src={props.image} alt={props.make + ' ' + props.model} />
            </div>
            <div className='auction-item__info'>
              <h3>{props.make} {props.model}</h3>
              <p>{props.description}</p>
              <h4>Current Bid: ${props.price}</h4>
              <p>Time Remaining: {timeRemaining}</p>
            </div>
            <div className='auction-item__actions'>
              { auth.isLoggedIn &&  (
                <>
                {auth.userId !== props.creatorId && (
                    <input 
                    type="number" 
                    value={bidPrice} 
                    onChange={(e) => setBidPrice(e.target.value)}
                    placeholder="Enter your bid" 
                />
                  )}
                  {auth.userId !== props.creatorId && (
                    <Button onClick={handleBidSubmit}>Place Bid</Button>
                  )}
                  <Button onClick={() => setShowDetailsModal(true)}>View Details</Button>
                  {auth.userId === props.creatorId && (
                    <Button danger onClick={showConfirmationHandler}>Delete</Button>
                  )}
                </>
              )}
            </div>
          </Card>
        )}
      </li>
    </>
  );
}

export default AuctionItem;
