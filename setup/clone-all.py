import requests
import os
import subprocess

# CONFIGURATION
username = "mterczynski"
token = ""  # Use a personal access token
clone_dir = os.path.expanduser("~/Desktop/dev/github")  # Directory to store cloned repos

# Create output directory
os.makedirs(clone_dir, exist_ok=True)

# Pagination variables
page = 1
per_page = 100  # max per GitHub API

while True:
    print(f"Fetching page {page}...")
    url = f"https://api.github.com/user/repos?per_page={per_page}&page={page}&affiliation=owner"
    response = requests.get(url, auth=(username, token))

    if response.status_code != 200:
        print("Error:", response.status_code, response.text)
        break

    repos = response.json()
    if not repos:
        break

    for repo in repos:
        clone_url = repo["clone_url"].replace("https://", f"https://{username}:{token}@")
        repo_name = repo["name"]
        dest_path = os.path.join(clone_dir, repo_name)

        if os.path.exists(dest_path):
            print(f"Skipping already cloned repo: {repo_name}")
        else:
            print(f"Cloning {repo_name}...")
            subprocess.run(["git", "clone", clone_url], cwd=clone_dir)

    page += 1
