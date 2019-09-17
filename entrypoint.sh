#!/bin/sh

set -e

echo -e "\033[35m======================  ENV ====================\033[0m"
env
echo "======================  ENV ===================="

ACCESS_TOKEN=$1
BRANCH=$2
CNAME=$3
FOLDER='public'

if [ -z "$ACCESS_TOKEN" ]; then
    echo "Please set access_token refer to https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line"
    exit 1
fi

if [ -z "$BRANCH" ]; then
    echo "if you are personal page, set branch to master"
    echo "if you are origianztaion page, set branch gh-pages"
    echo "if you just want test, the default branch is test-wxdlong-page"
    exit 1
fi

if [ -z "$FOLDER" ]; then
    echo "which content you want deploy. related path to the root repo"
    exit 1
fi

echo "====================  Hugo Site =================="
chmod +x /usr/local/bin/hugo
/usr/local/bin/hugo

echo "====================  Hugo Site =================="

cd $FOLDER

if [ ! -z "$CNAME" ]; then
    {
        echo "${CNAME}" >CNAME
        echo "write ${CNAME} to CNAME"
    }
fi

COMMIT_NAME=wxdlong
COMMIT_EMAIL=wxdlong@qq.com
COMMIT_MSG="Deploy by wxdlong/push-action."
REMOTE="https://${ACCESS_TOKEN}@github.com/${GITHUB_REPOSITORY}.git" #GITHUB_REPOSITORY is pass from action env

echo "git config user.email=${COMMIT_EMAIL}"
echo "git config user.name=${COMMIT_NAME}"
git config --global user.email "${COMMIT_EMAIL}" &&
    git config --global user.name "${COMMIT_NAME}"

echo "====================  Push page =================="

git init
git add --all
git commit -m "${COMMIT_MSG}"
echo "git remote add origin ${REMOTE}"
git remote add origin ${REMOTE}
git push --force origin master:${BRANCH}
echo "====================   Success  =================="
