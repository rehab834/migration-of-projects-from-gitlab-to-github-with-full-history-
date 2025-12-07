# migration-of-projects-from-gitlab-to-github-with-full-history-
# GitLab to GitHub Migration Script (Automatically)

This repository contains a **Bash script** that automatically migrates
all repositories you have access to on **GitLab** (including group-owned
repositories) to your **GitHub** account.\
It preserves:

-   ✔ Full commit history\
-   ✔ All branches\
-   ✔ All tags\
-   ✔ Repository names

------------------------------------------------------------------------

## 🚀 Features

-   Fetches all GitLab repositories you are a member of\
-   Clones them with full history (`--mirror`)\
-   Creates corresponding repositories on GitHub\
-   Pushes everything to GitHub automatically\
-   Removes local mirror clones after migrating

------------------------------------------------------------------------

## 📌 Prerequisites

### 1️⃣ Install required tools

``` bash
sudo apt update
sudo apt install -y git curl
```

------------------------------------------------------------------------

### 2️⃣ Create Personal Access Tokens

#### **GitLab Access Token**

Go to:\
**GitLab → Settings → Access Tokens**

Give these permissions:

-   `api`
-   `read_repository`

Copy the token and keep it safe.

------------------------------------------------------------------------

#### **GitHub Access Token**

Go to:\
**GitHub → Settings → Developer Settings → Personal Access Tokens
(Fine-grained)**\
or **Classic PAT**

Give these permissions:

-   `repo` (required for private repos)

------------------------------------------------------------------------

## ⚙️ Configure the Script

Edit the top of `migration.sh` and set:

``` bash
GITLAB_USER="your_gitlab_username"
GITHUB_USER="your_github_username"
GITLAB_TOKEN="your_gitlab_personal_access_token"
GITHUB_TOKEN="your_github_personal_access_token"
```

------------------------------------------------------------------------

## ▶️ Run the Migration

Make the script executable:

``` bash
chmod +x migration.sh
```

Run it:

``` bash
./migration.sh
```

------------------------------------------------------------------------

## 📦 What the Script Does

For each GitLab repo:

1.  Detects repository URL\
2.  Clones using `--mirror` (full history & refs)\
3.  Creates a matching GitHub repository via API\
4.  Pushes all content:
    -   branches\
    -   tags\
    -   refs\
5.  Cleans up local mirrored repo

------------------------------------------------------------------------

## 📝 Notes

-   GitLab group repositories **are supported**.
-   You must have at least **Guest** access to the group to migrate
    repositories.
-   Tokens must be valid and have required permissions.
-   Repositories on GitHub will be created as **private** (default).

------------------------------------------------------------------------

## 🏁 Done

After running the script, all your GitLab repositories will appear on
your GitHub account with full history preserved.

If you want to enhance the script (logging, filtering, GitHub org
migration, etc.), feel free to extend it!
