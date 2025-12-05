# Simple CSV -> JSON processor for demo
import pandas as pd, json, os
INFILE = os.environ.get('INFILE', 'data/sales_sample.csv')
OUTDIR = os.environ.get('OUTDIR', '/tmp/processed')
os.makedirs(OUTDIR, exist_ok=True)

def process():
    df = pd.read_csv(INFILE)
    # very basic transform: total per order
    agg = df.groupby('order_id').apply(lambda g: {'customer_id': g['customer_id'].iloc[0], 'total': (g['qty']*g['price']).sum()}).to_dict()
    out = {'orders': agg}
    outpath = os.path.join(OUTDIR, 'orders.json')
    with open(outpath, 'w') as f:
        json.dump(out, f, indent=2)
    print("Wrote:", outpath)

if __name__ == '__main__':
    process()
