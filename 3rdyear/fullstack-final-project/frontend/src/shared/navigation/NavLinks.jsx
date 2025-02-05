import { NavLink } from 'react-router-dom';
import { useContext } from 'react';

import { AuthContext } from '../context/auth-context';

import './NavLinks.css';

const NavLinks = (props) => {
  const auth = useContext(AuthContext);

  return (
    <ul className="nav-links">
      <li>
          <NavLink to="/" exact="true">ALL AUCTIONS</NavLink>
      </li>
      { auth.isLoggedIn && (
        <li>
          <NavLink to="/auctions/new">START NEW AUCTION</NavLink>
        </li>
      )}
      { !auth.isLoggedIn && (
        <li>
          <NavLink to="/auth">LOG IN</NavLink>
        </li>
      )}
      { auth.isLoggedIn && (
        <li>
          <button onClick={ auth.logout }>LOGOUT</button>
        </li>
      )}
      
    </ul>
  )
}

export default NavLinks;
