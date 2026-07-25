from flask import Flask, render_template
import os

app = Flask(__name__)


@app.route("/")
def welcome():
    """Welcome page for the dashboard application."""
    return render_template("index.html")


@app.route("/health")
def health():
    """Simple health-check endpoint (useful for Harness / k8s liveness probes)."""
    return {"status": "healthy"}, 200


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
