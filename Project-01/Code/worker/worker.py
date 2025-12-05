# Simple worker that could be run as a Kubernetes CronJob or Cloud Run Job
# For demo, it just prints a simulated inventory sync action.
import time, json, random
def run():
    print("Starting inventory worker...")
    for i in range(3):
        prod = random.choice(['Classic T-Shirt','Running Shoes','Coffee Mug'])
        delta = random.randint(-2, 5)
        print(f"Updating inventory for {prod}: {delta}")
        time.sleep(1)
    print("Worker finished.")

if __name__ == '__main__':
    run()
