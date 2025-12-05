from flask import Flask, jsonify, request
app = Flask(__name__)

# naive in-memory model: recommend top 2 products by static popularity
POPULAR = [2,1,3]
PRODUCTS = {1: 'Classic T-Shirt', 2: 'Running Shoes', 3: 'Coffee Mug'}

@app.route('/recommendations')
def recs():
    user = request.args.get('user_id','anonymous')
    # return top-2 as demo
    out = [{'product_id': pid, 'name': PRODUCTS.get(pid)} for pid in POPULAR[:2]]
    return jsonify({'user': user, 'recommendations': out})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
