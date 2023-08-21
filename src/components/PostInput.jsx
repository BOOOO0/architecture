import React, { useEffect } from 'react';
import axios from 'axios';
import { useState } from 'react';
import { useNavigate } from "react-router-dom";

const PostInput = () => {
    const [myText,editMyText] = useState("");
    const navigate = useNavigate();

    const onChange = (e) =>{
      editMyText(e.target.value);
    }

    const onSubmit = (e) => {
      e.preventDefault();
      console.log(myText);
      axios({
        method: "POST",
        url: "http://10.0.0.6:5173/",
        headers: {
          "Content-Type": "application/json",
        },
        data : JSON.stringify({
          text : myText
        }),
      })
      .then((response)=>console.log(response))
      .catch((error)=>console.log(error));
    };
    
    const toGetData = () => {
      navigate("/content");
    };


    return (
        <div >
        <form onSubmit={onSubmit}>
          <input value={myText} name="text" type="text" onChange={onChange}></input>
          <input type="submit"></input>
        </form>
        <button style={{
          border : "1px solid"
        }}onClick={toGetData}>조회</button>
      </div>
    );
};

export default PostInput;