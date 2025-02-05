import React from 'react';
import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, screen, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { MemoryRouter } from 'react-router-dom';
import Authenticate from './Authenticate';
import { AuthContext } from '../../shared/context/auth-context';
import { loginUser, signUpUser } from '../api/users';
import { QueryClient, QueryClientProvider } from 'react-query';

vi.mock('../api/users', () => ({
  loginUser: vi.fn(() => Promise.resolve({ id: '123', token: 'abc' })),
  signUpUser: vi.fn(() => Promise.resolve({ id: '456', token: 'def' }))
}));

describe('Authenticate', () => {
  const authContextValue = { login: vi.fn() };
  const queryClient = new QueryClient();

  beforeEach(() => {
    render(
      <QueryClientProvider client={queryClient}>
        <AuthContext.Provider value={authContextValue}>
          <MemoryRouter>
            <Authenticate />
          </MemoryRouter>
        </AuthContext.Provider>
      </QueryClientProvider>
    );
  });

  it('allows a user to sign up and switches modes correctly', async () => {
    await userEvent.click(screen.getByText('Signup instead?'));

    await userEvent.type(screen.getByLabelText('Name'), 'New User');
    await userEvent.type(screen.getByLabelText('Email'), 'newuser@example.com');
    await userEvent.type(screen.getByLabelText('Password'), 'newpassword123');
    await userEvent.click(screen.getByRole('button', { name: 'SIGNUP' }));

    await waitFor(() => {
      expect(signUpUser).toHaveBeenCalledWith({
        name: 'New User',
        email: 'newuser@example.com',
        password: 'newpassword123'
      });
      expect(authContextValue.login).toHaveBeenCalledWith('456', 'def');
    });
  });

  it('allows a user to login after switching back from sign up mode', async () => {
    await userEvent.click(screen.getByText('Signup instead?'));
    await userEvent.click(screen.getByText('Login instead?'));

    await userEvent.type(screen.getByLabelText('Email'), 'user@example.com');
    await userEvent.type(screen.getByLabelText('Password'), 'password');
    await userEvent.click(screen.getByRole('button', { name: 'LOGIN' }));

    await waitFor(() => {
      expect(loginUser).toHaveBeenCalledWith({
        email: 'user@example.com',
        password: 'password'
      });
      expect(authContextValue.login).toHaveBeenCalledWith('123', 'abc');
    });
  });

  it('login form submission triggers the correct API call and actions', async () => {
    await userEvent.type(screen.getByLabelText('Email'), 'user@example.com');
    await userEvent.type(screen.getByLabelText('Password'), 'password');
    await userEvent.click(screen.getByRole('button', { name: 'LOGIN' }));

    await waitFor(() => {
      expect(loginUser).toHaveBeenCalledWith({
        email: 'user@example.com',
        password: 'password'
      });
      expect(authContextValue.login).toHaveBeenCalledWith('123', 'abc');
    });
  });
});
