const express = require('express');
const axios = require('axios');
const cors = require('cors');

const app = express();
const port = 3000;

app.use(cors());


// Базова URL для API
const BASE_URL = 'https://newsapi.org/v2/';
const API_KEY = '55205ef152da4681a5122a2e9bc0f1db';


// Універсальна функція для виконання запитів
const fetchData = async (endpoint) => {
    try {
        const response = await axios.get(`${BASE_URL}${endpoint}`, {
            headers: {
                'X-Auth-Token': API_KEY,
            },
        });
        return response.data;
    } catch (error) {
        throw new Error(`Error fetching data: ${error.message}`);
    }
};

// Маршрут для отримання таблиці ліги
app.get('/api/apple', async (req, res) => {
    const { leagueCode } = req.params;
    try {
        const data = await fetchData(`everything?q=apple&from=2024-12-01&to=2024-12-01&sortBy=popularity&apiKey=${API_KEY}`);
        res.json(data);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Запуск сервера
app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
});