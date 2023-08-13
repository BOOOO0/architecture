import React from 'react';
import axios from 'axios';

const input = () => {
    const onSubmit = (e) => {
      e.preventDefault();
        const request = axios.post("/",JSON.stringify(e.target.value), {
          headers: {
            "Content-Type": "application/json",
          },})
        .then((response)=>console.log(response.data))
        .catch((error)=>console.log(error));
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