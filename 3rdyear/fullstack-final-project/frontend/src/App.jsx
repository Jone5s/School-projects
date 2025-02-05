import { BrowserRouter as Router, Route, Routes, useNavigate } from 'react-router-dom';
import { QueryClient, QueryClientProvider } from 'react-query'; 
import { useCallback, useEffect, useState } from 'react';

import Auctions from './ads/pages/Auctions';
import AddAuction from './ads/pages/AddAuction';
import Authenticate from './users/pages/Authenticate';
import MainNavigation from './shared/navigation/MainNavigation';

import { AuthContext } from './shared/context/auth-context';

import './App.css'

const queryClient = new QueryClient();

function App() {
  const navigate = useNavigate();
  const [token, setToken] = useState(false);
  const [userId, setUserId] = useState(false);
  const [tokenExpirationDate, setTokenExpirationDate] = useState(false);

  const login = useCallback((uid, token, expiration) => {
    setToken(token);
    setUserId(uid);

    const tokenExpirationDate = 
      expiration || (new Date(new Date().getTime() + 1000 * 60 * 60));
    
    setTokenExpirationDate(tokenExpirationDate);
    
    localStorage.setItem(
      'userData',
      JSON.stringify({ 
        userId: uid, 
        token,
        expiration: tokenExpirationDate.toISOString()
      })
    );
    //navigate('/', { replace: true });
  }, [/*navigate*/]);

  const logout = useCallback(() => {
    setToken(null);
    setUserId(null);
    setTokenExpirationDate(null);
    localStorage.removeItem('userData');
  }, []);

  return (
    <AuthContext.Provider value={{
      isLoggedIn: !!token,
      token: token,
      userId: userId,
      login: login,
      logout: logout
    }}>
      <QueryClientProvider client={queryClient}>
          <MainNavigation />
          <main>
            <Routes>
              {token ? (
                <>
                  <Route path="/" element={<Auctions />} />
                  <Route path="/auctions/new" element={<AddAuction />} />
                </>
              ) : (
                <>
                  <Route path="/" element={<Auctions />} />
                  <Route path="/auth" element={<Authenticate />} />
                </>
              )}
            </Routes>
          </main>
      </QueryClientProvider>
    </AuthContext.Provider>
  );
}

export default App;
