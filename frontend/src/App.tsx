import { useState, useEffect } from 'react';
import axios from 'axios';
import reactLogo from './assets/react.svg';
import viteLogo from '/vite.svg';
import './App.css';

function App() {
  const [count, setCount] = useState(0);
  const [greeting, setGreeting] = useState('');

  useEffect(() => {
    const fetchGreeting = () => {
      axios.get('http://170.64.192.197:30824') // Replace with your backend service URL if running on a different host
        .then(response => {
          setGreeting(response.data);
        })
        .catch(error => {
          console.error('There was an error fetching the greeting!', error);
        });
    };

    // Fetch greeting immediately and then every 4 seconds
    fetchGreeting();
    const intervalId = setInterval(fetchGreeting, 4000);

    // Cleanup interval on component unmount
    return () => clearInterval(intervalId);
  }, []);

  return (
    <>
      <div>
        <a href="https://vitejs.dev" target="_blank">
          <img src={viteLogo} className="logo" alt="Vite logo" />
        </a>
        <a href="https://react.dev" target="_blank">
          <img src={reactLogo} className="logo react" alt="React logo" />
        </a>
      </div>
      <h1>{greeting ? greeting : 'Loading greeting...'}, I'm on a K8s</h1>
      <div className="card">
        <button onClick={() => setCount((count) => count + 1)}>
          count is {count}
        </button>
      </div>
    </>
  );
}

export default App;
