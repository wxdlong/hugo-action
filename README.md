## What

Build [Hugo](https://gohugo.io/) extended site, Deploy to [GitHub Pages](https://pages.github.com/)

## Why

Small docker, quickly build, simple use.

## How

The Action will generator Hugo pages in `public` folder, Then publish to the target branch.
### Quick start

Precondition: Config the  [Security Token](https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line) with name `ACCESS_TOKEN`

1. For personal Github page, assume your hugo code is on `blog` branch. Example: `https://github.com/wxdlong/wxdlong.github.io`


    ```yml
    name: Deploy to github page
    on:
    push:
        branches:
        - blog

    jobs:
    hugo-action:
        runs-on: ubuntu-latest
        name: Build Hugo Pages
        steps:
        - name: Checkout code
        uses: actions/checkout@v1

        - name: Hugo site and deploy 2 github page
        uses: wxdlong/hugo-action@master
        with:
            access_token: ${{ secrets.ACCESS_TOKEN }}
            cname: 'https://ycat.top'
            branch: 'master'
    ```
2. For Unit | Organization Github page. Example: waiting your input.

    ```yml
    name: Deploy to github page
    on:
    push:
        branches:
        - master

    jobs:
    hugo-action:
        runs-on: ubuntu-latest
        name: Build Hugo Pages
        steps:
        - name: Checkout code
        uses: actions/checkout@v1

        - name: Hugo site and deploy 2 github page
        uses: wxdlong/hugo-action@master
        with:
            access_token: ${{ secrets.ACCESS_TOKEN }}
            cname: 'https://ycat.top'
    ```
    
> The different between these is Unit page need push to branch `gh-pages`

### Parameters


|  Parameter   | Description |  Required  |  Default |
|  ----  | ----  |  ----  | ----  |
| access_token  | GitHub personal access token. Refer to [site](https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line)) |  YES | NULL |
| branch  | The GitHub page repo branch you want push. Use `gh-pages` for Unit, use `master` for personal | YES | `gh-pages` |
| cname  | Your DNS name | NO | NULL |


## Base on

Hugo Version: 
Git Version: 