const express = require('express');
const fetch = require('node-fetch');
const app = express();
const PORT = process.env.PORT || 8080;
const RECO_URL = process.env.RECO_URL || 'http://localhost:5000';

app.get('/', async (req,res) => {
  const user = req.query.user || 'u100';
  try {
    const r = await fetch(`${RECO_URL}/recommendations?user_id=${user}`);
    const j = await r.json();
    res.send(`<h1>Recommendations for ${user}</h1><pre>${JSON.stringify(j,null,2)}</pre>`);
  } catch(e) {
    res.send('Failed to fetch recommendations: '+e);
  }
});

app.listen(PORT, () => console.log('Dashboard running on', PORT));
