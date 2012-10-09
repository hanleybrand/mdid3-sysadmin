## Get a github account, make a repo - or at least make issues 

Do it!  If you keep settings_local.pt in your .gitignore file you won't push sensitive info to the internet - and it makes asking questions about your code easier, because you can link specifically to the file that's causing problems. 

ALSO - having a github account will enable participation in community wikis, etc. 

ALSO - if you find an issue with mdid3, it's probably best to file it here, at least when you're sure what's causing the problem:  
https://github.com/cit-jmu/rooibos/issues

## Branching is best
It's best if you keep your server on it's own branch - this gives you the ability to switch to the canonical experimental branch, update, merge & confirm there are not problems after updating and then re-merge experimental with your own custom branch. This may seem like an extra step, but it's worth keeping your own modifications segmented away from the official repos. 

### How to set this up 

After you've successfully installed, create a branch before making changes (I'm calling it 'ourSite' below). This can also be done directly after a successful fetch/merge from upstream (upstream is the standard name for a git repo that you've cloned, i.e. that you can not push to - in our collective case, upstream would be git://github.com/cit-jmu/rooibos.git ):

```
git branch create ourSite
git checkout ourSite
git branch
   master
   experimental
 * templeCustom 
```
Then do your customizations and commit the changes - 

```
git -am commit "commit message"
```

## Updating is Easyish

When some new changes strike your fancy, fetch from upstream

```
git fetch upstream
  remote: Counting objects: 67, done.
  remote: Compressing objects: 100% (20/20), done.
  remote: Total 44 (delta 33), reused 34 (delta 23)
  Unpacking objects: 100% (44/44), done.
  From git://github.com/cit-jmu/rooibos
    a79c65e..6e3b630  experimental -> upstream/experimental
    bd553f8..580e79a  jmu-production -> upstream/jmu-production
```
(You could also do 'git pull', but that auto-merges with... well, exactly. It automerges. In my opinion, when I could explain it without looking it up, I'll use git pull. In the meantime, I'll use 'git fetch' which gets the changes but keeps them in secret .gitland until I merge them somewhere explicitly.)

So then, I want to patch my local experimental branch, which I keep in sync and unchanged from the cit-jmu repo:

```
git checkout experimental
  Switched to branch 'experimental'
git status
  # On branch experimental
  nothing to commit (working directory clean)
git merge upstream/experimental
  Updating a79c65e..6e3b630
  Fast-forward
   rooibos/data/models.py              |   10 +++++-----
   rooibos/legacy/views.py             |    9 ++++++++-
   rooibos/solr/templates/browse.html  |   10 ++++++++++
   rooibos/solr/templates/results.html |   12 +++++++++---
   rooibos/solr/views.py               |    6 +++++-
   rooibos/urls.py                     |    4 ++++
   6 files changed, 41 insertions(+), 10 deletions(-)
```

Now, I switch back to my local customizations and then merge in the new changes

```
git checkout ourSite
   Switched to branch 'ourSite'
git merge experimental
  Merge made by recursive.
   rooibos/data/models.py              |   10 +++++-----
   rooibos/legacy/views.py             |    9 ++++++++-
   rooibos/solr/templates/browse.html  |   10 ++++++++++
   rooibos/solr/templates/results.html |   12 +++++++++---
   rooibos/solr/views.py               |    6 +++++-
   rooibos/urls.py                     |    4 ++++
   6 files changed, 41 insertions(+), 10 deletions(-)
```

Now, if there's no conflicts the output on your second merge will look like the first. 

If there are conflicts, read this:  http://genomewiki.ucsc.edu/index.php/Resolving_merge_conflicts_in_Git

Lastly, you'll almost always need to restart web services - either via ```sudo apachectl restart``` or ```iisreset``` depending. 

And hopefully, you've successfully updated!

## Is it really that simple?

Well, probably not. At least not all of the time. 

In the spirit of honesty, and lending a dose of reality to the above instructions:   

it is almost never as simple as I described above, but I've never had a problem that googling "what git said" didn't get me out of.  

An example, which I edited out of the instructions from when I went to apply the new files but which shows what working with git is often like, at least for me:
```
$ git checkout experimental
Switched to branch 'experimental'

$ git status
# On branch experimental
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#
rooibos/mdid2.xml
#
rooibos/mdid2migrateOut.txt
#
rooibos/nohup_solr
#
rooibos/settings_local-ldapTunic.py
#
solr/nohup_solr
nothing added to commit but untracked files present (use "git add" to track)

$ nano .gitignore
```
so I added files above to .gitignore
```
$ git status
# On branch experimental
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#
modified:   .gitignore
#
no changes added to commit (use "git add" and/or "git commit -a")
```
[sigh - I decide it's easy enough to fix my .gitignore file later]
```
$ git update-index --assume-unchanged .gitignore 
```
[btw - neat command, let's you essentially lie to git, or make git lie to itself about a file... but it's dangerous, so I only use it for gitignore]
```
$ git status
# On branch experimental
nothing to commit (working directory clean)

$ git merge upstream/experimental
Updating a79c65e..6e3b630
[blah blah]
 6 files changed, 41 insertions(+), 10 deletions(-)

$ git checkout templeCustom
error: Your local changes to the following files would be overwritten by checkout:
.gitignore
Please, commit your changes or stash them before you can switch branches.
Aborting
```
[huh, uh oh ...  ok, if that's the way you want to play it ... ]
```
$ git stash 
No local changes to save
```
   [hmmmmm]
```
$ git status
# On branch experimental
nothing to commit (working directory clean)

$ git checkout templeCustom
error: Your local changes to the following files would be overwritten by checkout:
.gitignore
Please, commit your changes or stash them before you can switch branches.
Aborting
$ git commit -am "committing changes to .gitignore"
# On branch experimental
nothing to commit (working directory clean)
```
    [oh boy]
```
$ git update-index --assume-unchanged .gitignore 
```
[maybe that will work]
```
$ git checkout templeCustom
error: Your local changes to the following files would be overwritten by checkout:
.gitignore
Please, commit your changes or stash them before you can switch branches.
Aborting
```
[nope]
```
$ git stash .gitignore 
```
[nope]
[huh]
[it occurs to me that the problem is the .gitignore in templeCustom (from before I updated) will overwrite what I have ignored and thus can't add. bleh. Ok, I guess I'll be double fixing .gitignore at some point.]
```
$ git checkout templeCustom -- .gitignore   
```
[another neat bit:  double dash filename after the checkout command will checkout a single file form another branch, overwriting what you have]
```
$ git checkout templeCustom
Switched to branch 'templeCustom'
```
[ah, there we go]
```
$ git merge experimental
Merge made by recursive.
```
[the rest went smoothly, which was nice]