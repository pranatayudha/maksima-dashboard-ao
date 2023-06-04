# Git Workflow Pinang Maksima

## Naming Branch

Before doing the task, make sure you create a branch first which is fetch from the `develop` branch. For naming branch, use the issue number assigned to you from JIRA.

```
git checkout origin develop
git pull origin develop
git checkout -b {your issue number}
```

Example:
```
git checkout -b PM2-123
```

> Note: If you are working on a task for another environment (eg: staging or production), make sure you also fetch from that branch

## Commit message

For commit messages, you can use the guide from the image below:

![Commit Message](https://i.ibb.co/NnhMZVk/git-commit.jpg)