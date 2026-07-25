# Dashboard App

A minimal Python (Flask) web app whose welcome page shows **"Welcome to Dashboard"**.
Includes a production-ready `Dockerfile` and sample Harness CI/CD pipeline + Kubernetes
manifests for deploying it via Harness.

## Project structure

```
dashboard-app/
├── app.py                     # Flask application
├── templates/
│   └── index.html             # Welcome page ("Welcome to Dashboard")
├── requirements.txt           # Python dependencies
├── Dockerfile                 # Container build
├── .dockerignore
├── .gitignore
└── harness/
    ├── pipeline.yaml          # Sample Harness CI (build+push) + CD (deploy) pipeline
    └── manifests/
        └── deployment.yaml    # K8s Deployment + Service used by the Harness service
```

## Run locally (no Docker)

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python app.py
# visit http://localhost:5000
```

## Run with Docker

```bash
docker build -t dashboard-app .
docker run -p 5000:5000 dashboard-app
# visit http://localhost:5000
```

## Push this to your own GitHub repo

```bash
cd dashboard-app
git init
git add .
git commit -m "Initial commit: dashboard app with Dockerfile"
git branch -M main
git remote add origin https://github.com/<your-username>/<your-repo>.git
git push -u origin main
```

## Deploying via Harness

The `harness/` folder has starter files, not a finished pipeline — you'll need to
fill in the placeholders (`<YOUR_...>`) with values from your own Harness account:

1. **Connect this repo** in Harness as a Codebase/Git connector.
2. **Create a Docker registry connector** (Docker Hub, ECR, GCR, etc.) and reference
   it in `harness/pipeline.yaml` (`connectorRef`, `repo`).
3. **Import `harness/pipeline.yaml`** as a new pipeline (Pipelines → Create → Import
   from Git), or copy/paste its YAML into a new pipeline via the visual/YAML editor.
4. The first stage (`CI`) builds the image from this repo's `Dockerfile` and pushes
   it to your registry.
5. The second stage (`Deployment`, Kubernetes) rolls it out using
   `harness/manifests/deployment.yaml` — point your Harness **Service** at that
   manifest and your **Environment/Infrastructure** at your target cluster.
6. Replace `<YOUR_PROJECT_ID>`, `<YOUR_ORG_ID>`, `<YOUR_ENVIRONMENT_ID>`,
   `<YOUR_INFRA_ID>`, `<YOUR_DOCKER_CONNECTOR_ID>`, and the registry path with your
   actual Harness/registry values.

Once deployed, hitting the service's exposed URL should show the **"Welcome to
Dashboard"** page. A `/health` endpoint is included for readiness/liveness probes.
