#!/bin/bash

mkdir -p ~/.config/git/githooks
git config --global core.hooksPath "~/.config/git/githooks"

echo '#!/bin/bash

PACKAGE_NAME="gitleaks"

# check install gitleaks or not
if brew list -1 | grep -q "^${PACKAGE_NAME}\$"; then
    echo "${PACKAGE_NAME} has installed。"
else
    echo "${PACKAGE_NAME} did not installed, will install now。"
    brew install gitleaks
fi

# scan commit has sensitive information or not when pre-commit on staged
gitleaks protect --staged

if [ $? -eq 1 ]; then
    echo "your commit has include sensitive information, inhibit commit!!"
    exit 1
fi' >  ~/.config/git/githooks/pre-commit
