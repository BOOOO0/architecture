import { useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import './App.css'

function App() {
  const [count, setCount] = useState(0)
  const onSubmit = (e) => {
    e.preventDefault();
  };


  return (
    <>
      <div >
        <form onSubmit={onSubmit}>
          <input type="text"></input>
          <input type="submit"></input>
        </form>
      </div>
    </>
  )
}

export default App
