---
title: Happy (git) Trees
date: 2014-12-04 09:12:06
tags:
---

_originally posted on the Intridea blog here: http://www.intridea.com/blog/2014/12/4/happy-git-trees_

![Bob Ross](http://3.bp.blogspot.com/-euwIyl4tzDE/UjYU3GBaLgI/AAAAAAAAAQo/3V1b37kuISI/s1600/o-BOB-ROSS-facebook.jpg)

<br>We all know Bob Ross (above) and his fascination with "Happy Little Trees" (or maybe that's my fascination). In any case, we can all take some advice from Bob and keep our Git trees happy.

If you took a look at your current project's git tree (through a tool maybe like [Gitx](http://gitx.frim.nl/)) I bet it would look something like this: 

![Git tree](https://i.stack.imgur.com/r1wP7.png)

Now I don't know about you, but that is really hard for me to follow. I can get the general picture, that there are some branches that merged back into master, but then there's some branching off of branches and merges between branches; I can't really tell what story the git tree is trying to tell.

#### Why do we care about "Happy Trees"?

It is my view of git that all of your commits should tell a story of new functionality. This lets your coworkers or, as in the case of Intridea, clients see very plainly the set of commits that led to a feature being added to the application. It potentially lets less experienced developers see what steps you took to add a feature, and shows your train of thought on how you went from 0 to feature (hero).

Essentially, keeping a happy and clean git tree is about communication.

#### What does a Happy (git) tree look like?

Great question! Everyone has their own opinions on what a happy and clean git tree looks like (well, some have no opinion at all); this is my opinion on what a happy and clean tree might look like:

![Happy (git) Tree](https://dl.dropboxusercontent.com/u/539427/Screenshot%202014-11-20%2014.59.44.png)

I created this by just initializing a blank git repository and making some commits on master and two different branches. As you can see, it's clearly communicated what work occured on the branch and what commits happened directly on master. This makes it very easy to track down a potential bug, and which commit or merge may have caused it. Also, this makes it very easy to revert an entire feature should it no longer be wanted or if it's causing bugs. All you need to do is revert the merge commit and like magic, the feature is gone.

#### How do 'I' make my own Happy (git) trees?

Another AMAZING question! You too can have happy little (git) trees, just follow the guidelines below:

- If you are working on a feature that takes more than one commit to implement (you are keeping small commits, right?), make a git branch `git checkout -b <branch_name>` and do all of your coding on there.
- Before you are ready to merge it back into master, rebase it off of master `git fetch && git rebase origin/master`. 
  - Essentially what a rebase does (if you do not already know) is rewrite your branch's git history by removing your commits, updating your branch so that it's the same as `master` then replaying your commits one at a time on top of the new `HEAD`. **Note:** For a more complete visual explanation of `git rebase` please see [this](http://git-scm.com/book/en/v2/Git-Branching-Rebasing).
- When you are ready to merge your feature branch back into `master`, you can check out master `git checkout master`, update master via `git rebase origin/master`, and merge your branch using the "no fast forward" option `git merge --no-ff <branch_name>`
  - What the `--no-ff` option does is not replay your commits back onto master, but instead makes a merge commit of all the changes in your branch (_It should be noted that this is what a GitHub Pull-request does_) 

#### A bit more about `git rebase` and conflicts

Often, if you are working on a team, you will have conflicts when you rebase your branch from `master`. This is fine--do not panic--it just means that another person updated the same code you did and merged it in before you. What will happen then is the rebase will stop in the middle and you will have to manually fix the conflicts. If you type in `git status` it will show you which files have conflicts, you can simply open them and see which changes you made that are in conflict with the changes on master (which will be denoted with `<<<<<<` and `========`), then add or delete the code necessary to incorporate both changes in the code (if necessary). Once you are done fixing the conflicts (this includes deleting the `<<<<` and `====` mark up), go back to the command line and type `git add .` then `git rebase --continue` to continue along your path to having a happy (git) tree.

It is for this reason that if I am working on a feature branch, I rebase it after almost every commit, just to make sure I am kept up to date with `master`. I don't like fixing conflicts, and this ensures that I have as few of them as possible at one time.

#### Now, a bit more about GitHub and rebasing

If you are like me, you use GitHub to store your code, and you use pull requests on GitHub to have someone review your code (you are having someone review your code, [right?](http://www.intridea.com/blog/2014/8/12/on-code-cleanliness-and-readability)). In order to take advantage of GitHub _and_ `git rebase` you will need to rebase your branches before you make a pull request, otherwise you could end up with a spaghetti like tree as shown above.
