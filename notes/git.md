# Git

Push to remote: `git push origin <branch name>`
`git push origin <local branch name>:<remote branch name>`

Check out one file from another branch:
`git checkout <branch> -- <file>`

Compare a between branches:
`git diff branch1 branch2 -- <file>`

List just the names of files changed
`git diff --name-only master <branch>`

Append changes to previous commit:
`git add <files>`
`git commit --amend --no-edit`

Delete a branch
`git branch -d <branch name>`

View log with just one line per commit
`git log --pretty=oneline`

Git reset:
To get rid of all changes and go back to another commit:
`git reset --hard HEAD` to go back to last commit
`git reset --hard <commit id>` to go back to a different commit
`git checkout -- <file name>` will reset the file to HEAD

Undo git reset hard
`git reset ORIG_HEAD`

If you branched off of the wrong branch (branch1) instead of master and want to
eliminate those commits:
`git rebase --onto master branch1 branch2`

Take one commit from another branch:
`git cherry-pick <commit hash>`

See previous n commits and edit them using `pick` or `reword` or other options
- choose squash for squashing commits
`git rebase -i HEAD~n`

Merge all commits from another branch as 1 commit
`git merge --squash <branch>`

## Resources
Add an existing project to github:
[link](https://help.github.com/articles/adding-an-existing-project-to-github-using-the-command-line/)   
