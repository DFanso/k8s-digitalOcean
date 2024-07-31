const express = require('express');
const cors = require('cors');
const app = express();
const port = 3000;

const greetings = [
    "Hello, World!",
    "Hi there!",
    "Greetings!",
    "Howdy!",
    "Good day!"
];

// Use the cors middleware
app.use(cors());

app.get('/', (req, res) => {
    const randomGreeting = greetings[Math.floor(Math.random() * greetings.length)];
    res.send(randomGreeting);
});

app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
