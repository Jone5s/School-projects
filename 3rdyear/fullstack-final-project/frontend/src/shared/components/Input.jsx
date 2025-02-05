import React, { forwardRef } from 'react';
import './Input.css';

const Input = forwardRef((props, ref) => {
  return (
    <div className='form-control'>
      <label htmlFor={props.id}>{props.label}</label>
      <input
        ref={ref}
        id={props.id} // Make sure each input has a unique id
        type={props.type}
        placeholder={props.placeholder}
        className={props.error ? 'input-error' : ''}
      />
      {props.error && <p style={{ color: 'red' }}>{props.error}</p>}
    </div>
  );
});

Input.displayName = 'Input';

export default Input;
