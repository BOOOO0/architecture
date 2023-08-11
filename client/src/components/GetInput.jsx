import React from 'react';

const input = () => {
    const onSubmit = (e) => {
        e.preventDefault();
    };
    return (
        <div >
        <form onSubmit={onSubmit}>
          <input name="text" type="text"></input>
          <input type="submit"></input>
        </form>
      </div>
    );
};

export default input;