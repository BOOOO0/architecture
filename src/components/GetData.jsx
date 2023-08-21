import React, { useState, useEffect} from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

const GetData = () => {
    let [data, setData] = useState([]);
    const navigate = useNavigate();
    useEffect(() => {
      getData();
    }, []);

    const getData = async () => {
      await axios.get("http://localhost:5173/content").then((response)=>{
        setData(response.data);
      })
    };

    const toPostInput = () =>{
      navigate("/");
    }
    
    return (
        <div>
          <ul>
            {data.map(function(item){
              return (<li>{item}</li>);
            })}
          </ul>
          <button onClick={toPostInput}>돌아가기</button>
        </div>
    );
};

export default GetData;