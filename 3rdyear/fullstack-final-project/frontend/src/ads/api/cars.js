// Function to fetch all auctions from the API
export const getAuctions = async () => {
  const response = await fetch(`${import.meta.env.VITE_API_URL}/api/ads`);
  const auctions = await response.json();
  return auctions;
};

// Function to add a new auction to the API
export const addAuction = async ({
  make, model, image, price, description, hp, fueltype, displacement, end_time, token
}) => {

  const response = await fetch(`${import.meta.env.VITE_API_URL}/api/ads`, {
      method: 'POST',
      headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token  // Include the authorization token in the header
      },
      body: JSON.stringify({
          make, model, image, price, description, hp, fueltype, displacement, end_time
      })
  });

  if (!response.ok) {
      const errorData = await response.json();
      throw new Error(`HTTP error ${response.status}: ${errorData.message}`); // Throw detailed error on failure
  }
  return await response.json();  // Return the JSON response containing the new auction details
};

// Function to delete an auction by its ID
export const deleteAuction = async({id, token}) => {
  const response = await fetch(`${import.meta.env.VITE_API_URL}/api/ads/` + id, {
    method: 'DELETE',
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + token  // Authorization header with the token
    }
  });
  return await response.json();  // Return the response from the server
};

// Function to edit an existing auction
export const editAuction = async ({ id, make, model, image, price, description, token }) => {
  const url = `${import.meta.env.VITE_API_URL}/api/ads/${id}`;
  const data = {
    make,
    model, 
    image,
    price,
    description
  };

  const response = await fetch(url, {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + token  // Include the token in the header for authentication
    },
    body: JSON.stringify(data)
  });

  if (!response.ok) {
    throw new Error('Failed to update auction'); // Throw an error if the PATCH request fails
  }

  return await response.json(); // Return the updated auction data
};

// Function to place a bid on an auction
export const bidAuction = async ({ id, highestBid, token }) => {
  const response = await fetch(`${import.meta.env.VITE_API_URL}/api/ads/${id}/price`, {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${token}`
    },
    body: JSON.stringify({ price: highestBid })  // Send the bid as 'price' in the body
  });

  if (!response.ok) {
    const errorData = await response.json();
    throw new Error(errorData.message || 'Failed to place bid'); // Detailed error message from the server
  }

  return response.json(); // Return the response from the server after bidding
};

// Function to fetch auctions created by a specific user
export const getAuctionsByUserId = async (creatorId) => {
  const url = `${import.meta.env.VITE_API_URL}/api/ads?creatorId=${creatorId}`;

  const response = await fetch(url, {
    method: 'GET',
    headers: {
      'Accept': 'application/json'
    }
  });

  if (!response.ok) {
    throw new Error('Failed to fetch auctions'); // Throw an error if the GET request fails
  }

  const auctions = await response.json();
  return auctions;
};
