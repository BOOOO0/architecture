import { BrowserRouter, Routes, Route } from 'react-router-dom';
import './App.css'
import PostInput from './components/PostInput.jsx'
import GetData from './components/GetData'

function App() {
  return (
    <>
      <BrowserRouter>
				<Routes>
					<Route path="/" element={<PostInput />}></Route>
					<Route path="/content" element={<GetData />}></Route>
				</Routes>
			</BrowserRouter>
    </>
  )
}

export default App
