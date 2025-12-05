const express = require('express');
const app = express();
const PORT = process.env.PORT || 8080;

// Simple static page that fetches from backend API
app.get('/', (req, res) => {
  res.send(`
    <html>
      <head><title>Retail Frontend</title></head>
      <body>
        <h1>Retail Frontend (Project A)</h1>
        <div id="products">Loading products...</div>
        <script>
          fetch('/api/products')
            .then(r => r.json())
            .then(data => {
              const el = document.getElementById('products');
              el.innerHTML = '<ul>' + data.map(p => '<li>' + p.name + ' — ' + p.price + '</li>').join('') + '</ul>';
            })
            .catch(e => { document.getElementById('products').innerText = 'Failed to load products: ' + e; });
        </script>
      </body>
    </html>
  `);
});

// Proxy to backend service url configured by env var BACKEND_URL, default localhost:5000
const BACKEND_URL = process.env.BACKEND_URL || 'http://localhost:5000';

app.get('/api/products', async (req, res) => {
  try {
    const fetch = require('node-fetch');
    const r = await fetch(`${BACKEND_URL}/api/products`);
    const j = await r.json();
    res.json(j);
  } catch (e) {
    res.status(500).json({error: String(e)});
  }
});

app.listen(PORT, () => console.log('Frontend listening on', PORT));
