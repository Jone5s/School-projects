import React from 'react';
import { describe, it, expect, vi, beforeEach, afterEach } from 'vitest';
import { render, fireEvent, screen, act } from '@testing-library/react';
import { AuthContext } from '../../shared/context/auth-context';
import { QueryClient, QueryClientProvider } from 'react-query';
import AuctionItem from './AuctionItem';

// Mock portals in ReactDOM
vi.mock('react-dom', async (importOriginal) => {
    const actualReactDOM = await importOriginal();
    return {
      ...actualReactDOM,
      createPortal: (node) => node, // Render portal children as normal children
    };
  });

const queryClient = new QueryClient();

// Mock auth context
const authContextValue = {
  isLoggedIn: true,
  token: 'fake-token',
};

describe('AuctionItem', () => {
  beforeEach(() => {
    vi.useFakeTimers();
    const modalRoot = document.createElement('div');
    modalRoot.setAttribute('id', 'modal-hook');
    const backdropRoot = document.createElement('div');
    backdropRoot.setAttribute('id', 'backdrop-hook');
    document.body.appendChild(modalRoot);
    document.body.appendChild(backdropRoot);
  });

  afterEach(() => {
    act(() => {
      vi.runOnlyPendingTimers();
      vi.useRealTimers();
    });
    const modalRoot = document.getElementById('modal-hook');
    const backdropRoot = document.getElementById('backdrop-hook');
    if (modalRoot) {
      document.body.removeChild(modalRoot);
    }
    if (backdropRoot) {
      document.body.removeChild(backdropRoot);
    }
  });

  it('renders correctly', () => {
    const props = {
      id: 1,
      make: 'Toyota',
      model: 'Corolla',
      price: '20000',
      description: 'Reliable family car',
      image: 'http://localhost:5000/images/corolla.png',
      end_time: new Date(Date.now() + 1000 * 60 * 60 * 24).toISOString(), // 24 hours from now
    };

    render(
      <QueryClientProvider client={queryClient}>
        <AuthContext.Provider value={authContextValue}>
          <AuctionItem {...props} />
        </AuthContext.Provider>
      </QueryClientProvider>
    );

    expect(screen.getByText('Toyota Corolla')).toBeInTheDocument();
    expect(screen.getByText('Reliable family car')).toBeInTheDocument();
    expect(screen.getByText(/current bid: \$20000/i)).toBeInTheDocument();
  });


  it('updates the countdown timer', async () => {
    const oneMinuteFromNow = new Date(Date.now() + 1000 * 60).toISOString();
    const props = {
      id: 1,
      make: 'Toyota',
      model: 'Corolla',
      price: '20000',
      description: 'Reliable family car',
      image: 'http://localhost:5000/images/corolla.png',
      end_time: oneMinuteFromNow,
    };

    render(
    <QueryClientProvider client={queryClient}>  
      <AuthContext.Provider value={authContextValue}>
        <AuctionItem {...props} />
      </AuthContext.Provider>
    </QueryClientProvider>  
    );

    expect(screen.getByText(/time remaining:/i)).toBeInTheDocument();

    // Fast-forward time by one minute
    act(() => {
      vi.advanceTimersByTime(1000 * 60);
    });

    expect(screen.getByText(/Auction ended/i)).toBeInTheDocument();
  });

  it('opens confirmation modal when delete button is clicked', async () => {
    const props = {
      id: 1,
      make: 'Toyota',
      model: 'Corolla',
      price: '20000',
      description: 'Reliable family car',
      image: 'http://localhost:5000/images/corolla.png',
      end_time: new Date().toISOString(),
    };

    render(
      <QueryClientProvider client={queryClient}>
        <AuthContext.Provider value={authContextValue}>
          <AuctionItem {...props} />
        </AuthContext.Provider>
      </QueryClientProvider>
    );

    const deleteButton = screen.getByText('Delete');
    fireEvent.click(deleteButton);

    expect(screen.getByText('Are you sure?')).toBeInTheDocument();
  });
});