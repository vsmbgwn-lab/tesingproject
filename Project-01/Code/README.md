# Project A — Smart Inventory & Promotions Platform (Scaffold)

This scaffold contains a minimal, working application codebase for the capstone project A.
It includes a frontend (React), backend API (Flask), simple worker, Dockerfiles, Kubernetes manifests,
Cloud Run deployment script, Terraform placeholders, and Cloud Build example files.

## Included components
- frontend/  - React app that lists products and images from Cloud Storage (sample)
- backend/   - Flask API exposing /api/products and /api/inventory
- worker/    - Simple Python worker that can be used to simulate inventory updates
- k8s/       - Example Kubernetes manifests for backend deployment + HPA
- terraform/ - Starter Terraform files (modules to be filled per lab)
- cloudbuild/ - Example Cloud Build YAML pipelines

Run locally:
- Backend: `python backend/app.py`
- Frontend: `cd frontend && npm install && npm start` (or use the provided Dockerfile)

Note: This scaffold is intentionally simple. Replace credentials and provide Cloud SQL connection strings and other secrets via Secret Manager before deploying to GCP.
