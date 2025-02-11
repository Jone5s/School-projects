export const signUpUser = async ({name, email, password}) => {
  const response = await fetch(`${import.meta.env.VITE_API_URL}/api/users/signup`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    },
    body: JSON.stringify({
      name,
      email,
      password
    })
  });

  if (!response.ok) {
    const errorData = await response.json();
    throw new Error(errorData.message || 'Failed to sign up.');
  }

  return await response.json();
}

export const loginUser = async ({ email, password }) => {
  const response = await fetch(`${import.meta.env.VITE_API_URL}/api/users/login`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    },
    body: JSON.stringify({
      email,
      password
    })
  });

  if (!response.ok) {
    const errorData = await response.json();
    throw new Error(errorData.message || 'Failed to log in.');
  }

  return await response.json();
}
