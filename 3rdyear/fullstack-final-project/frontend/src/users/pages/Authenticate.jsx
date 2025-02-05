import React, { useContext, useRef, useState } from 'react';
import { useMutation } from 'react-query';
import { useNavigate } from 'react-router-dom';

import { loginUser, signUpUser } from '../api/users';
import { AuthContext } from '../../shared/context/auth-context';

import Button from '../../shared/components/Button';
import Card from '../../shared/components/Card';
import Input from '../../shared/components/Input';

import './Authenticate.css';

const Authenticate = () => {
  const auth = useContext(AuthContext);
  const navigate = useNavigate();

  const nameRef = useRef();
  const emailRef = useRef();
  const passwordRef = useRef();

  const [isLoginMode, setLoginMode] = useState(true);
  const [error, setError] = useState(null);

  const switchModeHandler = () => {
    setLoginMode(prevMode => !prevMode);
    setError(null);
  };

  const handleAuthSuccess = (data) => {
    console.log(data);
    auth.login(data.id, data.token);
    navigate('/');
  };

  const handleAuthError = (error) => {
    setError(error.message);
  };

  const signUpUserMutation = useMutation(signUpUser, {
    onSuccess: handleAuthSuccess,
    onError: handleAuthError
  });

  const loginUserMutation = useMutation(loginUser, {
    onSuccess: handleAuthSuccess,
    onError: handleAuthError
  });

  const onSubmitHandler = (event) => {
    event.preventDefault();
    const userCredentials = {
      email: emailRef.current.value,
      password: passwordRef.current.value
    };

    if (isLoginMode) {
      loginUserMutation.mutate(userCredentials);
    } else {
      userCredentials.name = nameRef.current.value;
      signUpUserMutation.mutate(userCredentials);
    }
  };

  return (
    <Card className="authentication">
      {!isLoginMode ? <h2>Sign Up</h2> : <h2>Login</h2>}
      {error && <p className="error-message">{error}</p>}
      <form onSubmit={onSubmitHandler} data-testid="auth-form">
        {!isLoginMode && <Input id="name" ref={nameRef} type="text" label="Name" />}
        <Input id="email" ref={emailRef} type="text" label="Email" />
        <Input id="password" ref={passwordRef} type="password" label="Password" />
        <Button type="submit" disabled={signUpUserMutation.isLoading || loginUserMutation.isLoading}>
          {isLoginMode ? 'LOGIN' : 'SIGNUP'}
        </Button>
      </form>
      <Button inverse onClick={switchModeHandler}>
        {isLoginMode ? 'Signup instead?' : 'Login instead?'}
      </Button>
    </Card>
  );
};

export default Authenticate;
