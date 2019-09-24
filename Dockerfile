FROM wxdlong/hugo as hugo
FROM alpine/git:1.0.7

LABEL "com.github.actions.name"="Hugo in Action" \
    "com.github.actions.description"="Build Hugo extended site, Deploy to GitHub Page" \
    "com.github.actions.icon"="git-commit" \
    "com.github.actions.color"="orange" \
    "repository"="http://github.com/wxdlong/hugo-action" \
    "homepage"="https://ycat.top" \
    "maintainer"="wxdlong <wxdlong@qq.com>"
COPY --from=hugo /hugo /usr/local/bin/
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]