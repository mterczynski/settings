import os
import subprocess

import requests

# CONFIGURATION
USERNAME = "mterczynski"
CLONE_DIR = os.path.expanduser("~/dev/github")  # Directory to store cloned repos
PER_PAGE = 100  # max per GitHub API


def fetch_repos(username: str):
    """Yield all public repositories for a GitHub user."""
    page = 1

    while True:
        print(f"Fetching page {page}...")
        response = requests.get(
            f"https://api.github.com/users/{username}/repos",
            params={"per_page": PER_PAGE, "page": page, "type": "owner", "sort": "full_name"},
            headers={"Accept": "application/vnd.github+json"},
            timeout=30,
        )

        if response.status_code != 200:
            print("Error:", response.status_code, response.text)
            return

        repos = response.json()
        if not repos:
            return

        yield from repos
        page += 1


def main():
    os.makedirs(CLONE_DIR, exist_ok=True)

    for repo in fetch_repos(USERNAME):
        repo_name = repo["name"]
        clone_url = repo["clone_url"]  # already HTTPS
        dest_path = os.path.join(CLONE_DIR, repo_name)

        if os.path.exists(dest_path):
            print(f"Skipping already cloned repo: {repo_name}")
            continue

        print(f"Cloning {repo_name}...")
        result = subprocess.run(["git", "clone", clone_url], cwd=CLONE_DIR)
        if result.returncode != 0:
            print(f"Failed to clone {repo_name}")


if __name__ == "__main__":
    main()
