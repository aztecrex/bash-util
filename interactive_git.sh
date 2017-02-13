# safety net for rebase, creates a temp branch at current HEAD
alias reback='git branch -D REBASE_BACKUP; git branch REBASE_BACKUP'

# create a repository in github based on directory name
# requires a .gitignore be in place
gh-create-repo() {


  repo_name=$1

  dir_name=`basename $(pwd)`

  if [ "$repo_name" = "" ]; then
    repo_name=$dir_name
  fi

  if [ ! -f ".git" ]; then
    if [ ! -f ".gitignore" ]; then
      echo "not a github directory" >&2
      return 2
    fi
    git init > /dev/null 2>&1
    git add .gitignore > /dev/null 2>&1
    git commit -m "[initial]" > /dev/null 2>&1
  fi

  username=`git config github.user`
  if [ "$username" = "" ]; then
    echo "Could not find username, run 'git config --global github.user <username>'" >&2
    return 1
  fi

  token=`git config github.token`
  if [ "$token" = "" ]; then
    echo "Could not find token, run 'git config --global github.token <token>'" >&2
    return 1
  fi

  curl -u "$username:$token" -d '{"name":"'$repo_name'"}' https://api.github.com/user/repos > /dev/null 2>&1

  git remote add origin git@github.com:$username/$repo_name.git > /dev/null 2>&1
  git push -u origin master > /dev/null 2>&1
  git push origin --all > /dev/null 2>&1
  git push origin --tags > /dev/null 2>&1

}

# create a repository in github based on directory name
# requires a .gitignore be in place
gh-create-private-repo() {


  repo_name=$1

  dir_name=`basename $(pwd)`

  if [ "$repo_name" = "" ]; then
    repo_name=$dir_name
  fi

  if [ ! -f ".git" ]; then
    if [ ! -f ".gitignore" ]; then
      echo "not a github directory" >&2
      return 2
    fi
    git init > /dev/null 2>&1
    git add .gitignore > /dev/null 2>&1
    git commit -m "[initial]" > /dev/null 2>&1
  fi

  username=`git config github.user`
  if [ "$username" = "" ]; then
    echo "Could not find username, run 'git config --global github.user <username>'" >&2
    return 1
  fi

  token=`git config github.token`
  if [ "$token" = "" ]; then
    echo "Could not find token, run 'git config --global github.token <token>'" >&2
    return 1
  fi

  curl -u "$username:$token" -d '{"name":"'$repo_name'", "private":true}' https://api.github.com/user/repos > /dev/null 2>&1

  git remote add origin git@github.com:$username/$repo_name.git > /dev/null 2>&1
  git push -u origin master > /dev/null 2>&1
  git push origin --all > /dev/null 2>&1
  git push origin --tags > /dev/null 2>&1

}

# pull a suitable .gitignore from github. parameter is the language
# name from the git ignores project
gh-ignore() {
  language_name=$1
  if [ -f .gitignore ]; then
    echo ".gitignore already exists" >&2
    return 1
  fi
  if [ "$language_name" = "" ]; then
    echo "What language?" >&2
    return 2
  fi
  curl -L -s https://github.com/github/gitignore/raw/master/{$language_name}.gitignore > .gitignore
}
