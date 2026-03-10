import os
import sys
import json
from serpapi import Client

api_key = os.environ.get("SERPAPI_KEY")
if not api_key:
    raise EnvironmentError("SERPAPI_KEY environment variable is not set")

# Query priority: CLI arg > SEARCH_QUERY env var > default
if len(sys.argv) > 1:
    query = " ".join(sys.argv[1:])
else:
    query = os.environ.get("SEARCH_QUERY", "latest Kubernetes releases")

engine = os.environ.get("SEARCH_ENGINE", "google")
num_results = int(os.environ.get("NUM_RESULTS", "5"))

print(f"Query  : {query}")
print(f"Engine : {engine}")
print("-" * 60)

client = Client(api_key=api_key)

results = client.search({
    "q": query,
    "engine": engine,
})

# Optionally dump full JSON when DEBUG=1
if os.environ.get("DEBUG") == "1":
    print(json.dumps(results, indent=2))
    sys.exit(0)

# Print the top organic results
organic = results.get("organic_results", [])
print(f"Found {len(organic)} organic results (showing top {min(num_results, len(organic))})\n")
for i, r in enumerate(organic[:num_results], 1):
    print(f"{i}. {r.get('title')}")
    print(f"   {r.get('link')}")
    print(f"   {r.get('snippet', '')[:160]}")
    print()
