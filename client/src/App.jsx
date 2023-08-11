import { useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import './App.css'
import GetInput from './components/GetInput.jsx'

function App() {
  const [count, setCount] = useState(0)



  return (
    <>
      <GetInput/>
    </>
  )
}

export default App
