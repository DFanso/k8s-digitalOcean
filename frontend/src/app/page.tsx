import React from 'react';

const fetchInitialGreeting = async () => {
  const apiUrl = process.env.NEXT_PUBLIC_API_URL;
  try {
    const res = await fetch(`${apiUrl}/api`, { cache: 'no-store' });
    if (!res.ok) {
      throw new Error('Failed to fetch initial greeting');
    }
    const data = await res.json();
    return data.message;
  } catch (error) {
    console.error(error);
    return 'Hello';
  }
};

const Home = async () => {
  const initialGreeting = await fetchInitialGreeting();

  return (
    <div className="text-center mt-12">
      <div>{initialGreeting}</div>
    </div>
  );
};

export default Home;
