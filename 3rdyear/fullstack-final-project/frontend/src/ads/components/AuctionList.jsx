import React, { useState, useEffect, useContext } from 'react';
import AuctionItem from "./AuctionItem";
import { AuthContext } from '../../shared/context/auth-context';

import './AuctionList.css';

const AuctionsList = props => {
  // State for storing sorted list of auction items
  const [sortedItems, setSortedItems] = useState([]);
  // State for tracking the current sort type
  const [sortType, setSortType] = useState('make'); // Default sort type is by 'make'

  // Use auth context to access the current user's ID for filtering own auctions
  const auth = useContext(AuthContext);

  // Effect to sort items whenever the items list or sort type changes
  useEffect(() => {
    sortItems(sortType);
  }, [props.items, sortType]);

  // Function to sort auction items based on the selected sort type
  const sortItems = (type) => {
    const itemsSorted = [...props.items].sort((a, b) => {
      switch (type) {
        case 'myAuctions':
          // Prioritize user's own auctions in sorting
          if (a.creatorId === auth.userId && b.creatorId !== auth.userId) {
            return -1;
          }
          if (a.creatorId !== auth.userId && b.creatorId === auth.userId) {
            return 1;
          }
          return 0; // No change if both or neither are the user's auctions
        case 'price':
          // Sort by price, from lowest to highest
          return a.price - b.price;
        case 'endTime':
          // Sort by end time, soonest first
          return new Date(a.end_time) - new Date(b.end_time);
        case 'make':
        default:
          // Default to sorting alphabetically by make
          return a.make.localeCompare(b.make);
      }
    });
    setSortedItems(itemsSorted);
  };

  // Handler for changing the sort type
  const handleSortChange = (event) => {
    setSortType(event.target.value);
  };

  return (
    <div className="auctions-container">
      <div className="auctions-dropdown">
        <label>Sort by: </label>
        <select onChange={handleSortChange} value={sortType}>
          <option value="make">Make</option>
          <option value="myAuctions">My Auctions</option>
          <option value="price">Price</option>
          <option value="endTime">End Time</option>
        </select>
      </div>
      <ul className="auctions-list">
        {sortedItems.map(car => (
          // Render AuctionItem component for each item in the sorted list
          <AuctionItem
            key={car.id}
            id={car.id}
            make={car.make}
            model={car.model}
            image={car.image}
            price={car.price}
            description={car.description}
            hp={car.hp}
            fueltype={car.fueltype}
            displacement={car.displacement}
            end_time={car.end_time}
            creatorId={car.creatorId}
          />
        ))}
      </ul>
    </div>
  );
}

export default AuctionsList;
