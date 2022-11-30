import './App.css';

import {
  createBrowserRouter,
  RouterProvider,
} from "react-router-dom";

import Navbar from 'components/Navbar/index';

import Home from 'pages/Home/index';
import Contact from 'pages/Contact/index';

const router = createBrowserRouter([
  {
    path: "/",
    element: <Home />,
  },
  {
    path: "/app",
    element: <Home />,
  },
  {
    path: "/app/contact",
    element: <Contact />,
  },
]);

const App = () => 
  <div>
    <Navbar/>
    <RouterProvider router={router} />
  </div>

export default App;
