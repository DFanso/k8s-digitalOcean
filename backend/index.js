const express = require('express');
const cors = require('cors');
const app = express();
const port = 3000;

// Greetings array
const greetings = [
    "Hello, World!",
    "Hi there!",
    "Greetings!",
    "Howdy!",
    "Good day!"
];

// Use the cors middleware to allow requests from any origin
app.use(cors()); // To allow requests from any origin
// Or specify a specific origin
// app.use(cors({ origin: 'http://your-frontend-url.com' }));

// Endpoint to get a random greeting
app.get('/api', (req, res) => {
    const randomGreeting = greetings[Math.floor(Math.random() * greetings.length)];
    res.json({ message: randomGreeting }); // Sending response as a JSON object
});

// Start the server
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
