import React, { useState, useEffect} from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import DataList from './DataList'

const GetData = () => {
    const asd = "asd";
    let [data, setData] = useState([]);
    const navigate = useNavigate();

    useEffect(() => {
      getData();
    }, []);

    const getData = async () => {
      await axios.get("http://localhost:8080/").then((response)=>{
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