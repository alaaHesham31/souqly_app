require('dotenv').config();
const express = require('express');
const axios = require('axios');

const app = express();
app.use(express.json());

const PAYMOB_BASE = 'https://accept.paymob.com';

async function getAuthToken() {
  if (!process.env.PAYMOB_API_KEY) {
    throw new Error('Missing PAYMOB_API_KEY in .env');
  }
  const resp = await axios.post(`${PAYMOB_BASE}/api/auth/tokens`, {
    api_key: process.env.PAYMOB_API_KEY,
  });
  return resp.data.token;
}

// Health check
app.get('/health', (req, res) => res.json({ ok: true, ts: Date.now() }));

// Create payment
app.post('/api/paymob/create-payment', async (req, res) => {
  try {
    console.log('[create-payment] received body:', req.body);
    const { amount, currency = 'EGP', merchant_order_id, billing_data = {} } = req.body;
    if (!amount) return res.status(400).json({ error: 'amount is required' });

    const authToken = await getAuthToken();

    // 1) Create order
    const orderResp = await axios.post(`${PAYMOB_BASE}/api/ecommerce/orders`, {
      auth_token: authToken,
      delivery_needed: false,
      amount_cents: Math.round(amount * 100),
      currency,
      merchant_order_id: merchant_order_id || Date.now().toString(),
      items: [],
    });

    const orderId = orderResp.data.id;
    console.log('[create-payment] orderId:', orderId);

    // 2) Get payment key
    const paymentKeyResp = await axios.post(`${PAYMOB_BASE}/api/acceptance/payment_keys`, {
      auth_token: authToken,
      amount_cents: Math.round(amount * 100),
      expiration: 3600,
      order_id: orderId,
      billing_data,
      currency,
      integration_id: Number(process.env.PAYMOB_INTEGRATION_ID),
    });

    const paymentToken = paymentKeyResp.data.token;
    const iframeId = process.env.PAYMOB_IFRAME_ID;

    const iframeUrl = `${PAYMOB_BASE}/api/acceptance/iframes/${iframeId}?payment_token=${paymentToken}`;
    console.log('[create-payment] iframeUrl:', iframeUrl);

    return res.json({ iframeUrl, orderId, paymentToken });
  } catch (err) {
    console.error('Paymob create-payment error', err?.response?.data || err.message);
    return res.status(500).json({ error: 'server_error', details: err?.response?.data || err.message });
  }
});

//  Verify payment status
app.get('/api/paymob/verify', async (req, res) => {
  try {
    const { orderId } = req.query;
    if (!orderId) return res.status(400).json({ error: 'orderId required' });

    const authToken = await getAuthToken();

    // Correct endpoint is GET with query params
    const txResp = await axios.get(`${PAYMOB_BASE}/api/acceptance/transactions`, {
      params: { order_id: Number(orderId) },
      headers: { Authorization: `Bearer ${authToken}` },
    });

    return res.json({ status: 'ok', tx: txResp.data });
  } catch (err) {
    console.error('verify error', err?.response?.data || err.message);
    return res.status(500).json({ error: 'verify_error', details: err?.response?.data || err.message });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Paymob demo server running on ${PORT}`));
