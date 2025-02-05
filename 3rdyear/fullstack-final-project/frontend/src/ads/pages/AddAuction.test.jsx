import React from 'react';
import { render, screen } from '@testing-library/react';
import { QueryClient, QueryClientProvider } from 'react-query';
import { createMemoryHistory } from 'history';
import { Router } from 'react-router-dom';
import { AuthContext } from '../../shared/context/auth-context';
import AddAuction from './AddAuction';
import userEvent from '@testing-library/user-event';
import { vi } from 'vitest';
import { addAuction } from '../api/cars';

vi.mock('../api/cars', () => ({
  addAuction: vi.fn(),
}));

describe('AddAuction', () => {
  const authContextValue = { token: 'fake-token' };
  let history, queryClient;

  // Define the setup function
  const setup = () => {
    history = createMemoryHistory();
    queryClient = new QueryClient();

    render(
      <QueryClientProvider client={queryClient}>
        <AuthContext.Provider value={authContextValue}>
          <Router navigator={history} location={history.location}>
            <AddAuction />
          </Router>
        </AuthContext.Provider>
      </QueryClientProvider>
    );
  };

  beforeEach(() => {
    vi.clearAllMocks();
    setup(); // Call setup before each test
  });

  it('submits the form and calls addAuction', async () => {
    addAuction.mockResolvedValueOnce({ id: '123', message: 'Auction added' });

    await userEvent.type(screen.getByLabelText('Make'), 'Toyota');
    await userEvent.type(screen.getByLabelText('Model'), 'Corolla');
    await userEvent.type(screen.getByLabelText('Image Link'), 'http://example.com/corolla.jpg');
    await userEvent.type(screen.getByLabelText('Starting Price'), '20000');
    await userEvent.type(screen.getByLabelText('Description'), 'Reliable family car');
    await userEvent.type(screen.getByLabelText('Horsepower'), '123');
    await userEvent.type(screen.getByLabelText('Fuel Type'), 'Gasoline');
    await userEvent.type(screen.getByLabelText('Displacement'), '1800');
    await userEvent.type(screen.getByLabelText('End Time'), '2022-12-31T23:59');

    await userEvent.click(screen.getByRole('button', { name: 'Add Auction' }));

    expect(addAuction).toHaveBeenCalledWith({
      make: 'Toyota',
      model: 'Corolla',
      image: 'http://example.com/corolla.jpg',
      price: '20000',
      description: 'Reliable family car',
      hp: '123',
      fueltype: 'Gasoline',
      displacement: '1800',
      end_time: '2022-12-31T23:59',
      token: 'fake-token',
    });

    expect(history.location.pathname).toBe('/'); // Check if navigation occurred
  });
});
