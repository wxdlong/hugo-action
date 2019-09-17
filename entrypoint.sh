#!/bin/sh

set -e
cat <<EOF

██╗  ██╗██╗   ██╗ ██████╗  ██████╗     ██╗███╗   ██╗     █████╗  ██████╗████████╗██╗ ██████╗ ███╗   ██╗
██║  ██║██║   ██║██╔════╝ ██╔═══██╗    ██║████╗  ██║    ██╔══██╗██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║
███████║██║   ██║██║  ███╗██║   ██║    ██║██╔██╗ ██║    ███████║██║        ██║   ██║██║   ██║██╔██╗ ██║
██╔══██║██║   ██║██║   ██║██║   ██║    ██║██║╚██╗██║    ██╔══██║██║        ██║   ██║██║   ██║██║╚██╗██║
██║  ██║╚██████╔╝╚██████╔╝╚██████╔╝    ██║██║ ╚████║    ██║  ██║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║
╚═╝  ╚═╝ ╚═════╝  ╚═════╝  ╚═════╝     ╚═╝╚═╝  ╚═══╝    ╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝                                                                                               
EOF
function logI() {
    echo -e "\033[35m$1\033[0m"
}

function logE() {
    echo -e "\033[31m$1\033[0m"

}

logI "========================= ENV"
env
logI "Contact wxdlong@qq.com If any problem."
logI "$(hugo version)"
logI "$(git version)"

ACCESS_TOKEN=$1
BRANCH=$2
CNAME=$3
FOLDER='public'

if [ -z "$ACCESS_TOKEN" ]; then
    logE "Please set access_token refer to https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line"
    exit 1
fi

if [ -z "$BRANCH" ]; then
    logE "if you are personal page, set branch to master"
    logE "if you are origianztaion page, set branch gh-pages"
    exit 1
fi

logI "========================= Hugo Site "
chmod +x /usr/local/bin/hugo
/usr/local/bin/hugo

cd $FOLDER

if [ ! -z "$CNAME" ]; then
    {
        echo "${CNAME}" >CNAME
        logI "write ${CNAME} to CNAME"
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

logI "=========================  Push page "

git init
git add --all
git commit -m "${COMMIT_MSG}"
git remote add origin ${REMOTE}
git push --force origin master:${BRANCH}
logI "=========================   Success "