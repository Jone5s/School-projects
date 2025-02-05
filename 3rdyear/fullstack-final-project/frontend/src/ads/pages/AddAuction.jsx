import React, { useContext, useRef, useState } from 'react';
import { useMutation } from 'react-query';
import { useNavigate } from 'react-router-dom';

import Input from '../../shared/components/Input';
import Button from '../../shared/components/Button';
import { addAuction } from '../api/cars';
import { AuthContext } from '../../shared/context/auth-context';

const AddAuction = () => {
  const navigate = useNavigate();

  const makeRef = useRef();
  const modelRef = useRef();
  const imageRef = useRef();
  const priceRef = useRef();
  const descriptionRef = useRef();
  const hpRef = useRef();
  const fuelTypeRef = useRef();
  const displacementRef = useRef();
  const endTimeRef = useRef();

  const [errors, setErrors] = useState({});

  const auth = useContext(AuthContext);

  const createCarMutation = useMutation({
    mutationFn: addAuction
  });

  const validateInputs = () => {
    const newErrors = {};
    if (!makeRef.current.value) newErrors.make = 'Make is required';
    if (!modelRef.current.value) newErrors.model = 'Model is required';
    if (!imageRef.current.value) newErrors.image = 'Image link is required';
    if (!priceRef.current.value) newErrors.price = 'Starting price is required';
    if (!descriptionRef.current.value) newErrors.description = 'Description is required';
    if (!hpRef.current.value) newErrors.hp = 'Horsepower is required';
    if (!fuelTypeRef.current.value) newErrors.fuelType = 'Fuel type is required';
    if (!displacementRef.current.value) newErrors.displacement = 'Displacement is required';
    if (!endTimeRef.current.value) newErrors.endTime = 'End time is required';
    return newErrors;
  };

  const carSubmitHandler = async (event) => {
    event.preventDefault();
    const newErrors = validateInputs();
    if (Object.keys(newErrors).length > 0) {
      setErrors(newErrors);
      return;
    }
    setErrors({}); // Clear errors on successful validation
    createCarMutation.mutate({
      make: makeRef.current.value,
      model: modelRef.current.value,
      image: imageRef.current.value,
      price: priceRef.current.value,
      description: descriptionRef.current.value,
      hp: hpRef.current.value,
      fueltype: fuelTypeRef.current.value,
      displacement: displacementRef.current.value,
      end_time: endTimeRef.current.value,
      token: auth.token
    }, {
      onSuccess: () => {
        navigate('/'); // Redirect after successful creation
      }
    });
  };

  return (
    <form className="auction-form" onSubmit={carSubmitHandler}>
      <Input ref={makeRef} id="make" type="text" label="Make" error={errors.make} />
      <Input ref={modelRef} id="model" type="text" label="Model" error={errors.model} />
      <Input ref={imageRef} id="imageLink" type="text" label="Image Link" />
      <Input ref={priceRef} id="startingPrice" type="number" label="Starting Price" />
      <Input ref={descriptionRef} id="description" type="text" label="Description" />
      <Input ref={hpRef} id="horsepower" type="number" label="Horsepower" />
      <Input ref={fuelTypeRef} id="fuelType" type="text" label="Fuel Type" />
      <Input ref={displacementRef} id="displacement" type="text" label="Displacement" />
      <Input ref={endTimeRef} id="endTime" type="datetime-local" label="End Time" />
      <Button type="submit">Add Auction</Button>
      {Object.values(errors).map(error => (
        <p key={error} style={{ color: 'red' }}>{error}</p>
      ))}
    </form>
  );
}

export default AddAuction;
