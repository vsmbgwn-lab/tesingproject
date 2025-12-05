from flask import Flask, jsonify
app = Flask(__name__)

# In-memory sample products
PRODUCTS = [
    {"id": 1, "name": "Classic T-Shirt", "price": 12.99, "stock": 120},
    {"id": 2, "name": "Running Shoes", "price": 59.99, "stock": 30},
    {"id": 3, "name": "Coffee Mug", "price": 7.5, "stock": 200},
]

@app.route('/api/products')
def products():
    # In real deployment, read from Cloud SQL
    return jsonify(PRODUCTS)

@app.route('/api/inventory/<int:product_id>')
def inventory(product_id):
    p = next((x for x in PRODUCTS if x['id']==product_id), None)
    if not p:
        return jsonify({"error":"not found"}), 404
    return jsonify({"id": p['id'], "stock": p['stock']})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
