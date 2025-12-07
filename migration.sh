
#!/bin/bash

GITLAB_USER="your_user"
GITHUB_USER="your_user"
GITLAB_TOKEN="your_token"
GITHUB_TOKEN="your_token"


# Get list of GitLab repo SSH URLs using the GitLab API
repos=$(curl --silent --header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
"https://gitlab.com/api/v4/projects?membership=true&per_page=100" \
| grep -oP '"http_url_to_repo":"\K[^"]+')



if [ -z "$repos" ]; then
    echo "No repositories found for user $GITLAB_USER. Check your token or username."
    exit 1
fi

for repo in $repos; do
    name=$(basename "$repo" .git)
    echo "Migrating $name ..."
    
 # Clone repo with full history
    git clone --mirror "${repo/https:\/\/gitlab.com\//https://$GITLAB_USER:$GITLAB_TOKEN@gitlab.com/}"

    cd "$name.git" || continue

    # Create empty repo on GitHub
    curl -s -u "$GITHUB_USER:$GITHUB_TOKEN" https://api.github.com/user/repos \
    -d "{\"name\":\"$name\"}"

    # Push all branches and tags
    git push --mirror "https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$GITHUB_USER/$name.git"

    cd ..
    rm -rf "$name.git"

    echo "✅ Migration of $name completed."
done

