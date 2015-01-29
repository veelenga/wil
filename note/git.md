# Git notes
Created after reading [Pro Git - Scott Chacon, 2010](https://progit.org/)

Use all commands with `git` at the beginning(expect those that begins with `$` or `:`)

- [Help](#help)
- [Config](#config)
- [Staging/unstaging](#stagingunstaging)
- [Diff](#diff)
- [History](#history)
- [Undos](#undos)
- [Remote](#remote)
- [Tags](#tags)
- [Branching](#branching)
- [Server](#on-the-server)
- [Debugging](#debugging)
- [Submodules](#submodules)
- [Attributes](#attributes)
- [Hooks](#hooks)

## Help 
```sh
help config
config help
$man git-config
```

## Config
```sh
config --global merge.tool gvimdiff
config --global user.name "John Doe"
config --global user.email jogndoe@gmail.com
config --global commit.template $HOME/.gimessages.txt
config --global help.autocorrect 1
config --global color.diff.meta “blue black bold”
config --system receive.fsckObjects true  # Checks sha-1 sums before every push
config --system receive.denyNonFastForwards true
config --system receive.denyDeletes true
```

## Staging/unstaging
```sh
status                                # To see what is happening there :D
diff                                  # To see what is changed on unstaged area
rm/add *.c                            # Removes from disk/add to stage area files
diff --cached                         # To see what is changed on staged area
commit -m "Message"                   # Simple commit
rm --cached                           # Remove files only from stage area 
                                      #    (not from the disk)
mv file1 file2                        # Renames file in staged area the same as:
                                      #    mv file1 file2
                                      #    rm file1
                                      #    add file2
diff --check                          # Verify your changes before commit
add -i                                # Interactive menu. Very useful
add -p                                # Or --patch. Partial staging
stash                                 # Store your 'dirty' files
stash list                            # List of your stashes
stash apply                           # Revert (unstash) your repo
stash apply stash@{2}                 # Apply previous stash
stash apply --index                   # Try to apply stage changes on another 
                                      #    branch
stash show -p | git apply -R          # Unapply last stash
```

## Diff
```sh
mergetool                             # Tool to resolve conflict
                                      # vim diff
:diffget LO                           # Commands to resolve merge conflict with 
:diffget BA                           #   vimdiff resolving tool
:diffget RE
```

## History
```sh
log             
log -p                                # Shows the difference
log -2                                # Only two latest commits
log --stat                            # Stats
log --pretty=oneline                  # Short, full, fuller
log --since=2.weeks        
log --until=2.weeks
log --author=veelenga
log --grep=[Saas]
log path_to_folder/                   # To see history only of this folder

log --pretty=format:"%h - %cn, %cr : %s"
log --pretty=format:"%h %s" --graph
log --pretty='%h %s' --since=2.weeks --grep=Saas -- edx

reflog
show sha-1                            # Shows info about this commit
show master@{2.day.ago}
show HEAD@{1}

log master..anotherbranch             # Shows info about commit that are not
                                      #   reached from master but reached
                                      #   from anotherbranch
log origin/master..HEAD               # Shows what you will push
log origin/master..                   # Same result
log b1..b2                            # Those 3
log ^b1 b2                            #   are
log b2 --not b1                       #   equivalent
log b1 b2 ^b3                         # All commit that are reachable from b1
                                      #   or b2 but not from b3
log master...expirement               # To specify what is in master and
                                      #   but not any common references
log --left-right master..expirement   # The same but in readable format
```

## Undos
```sh
commit --amend                        # Replaces current stage area with latest 
                                      # commit. For example:
                                      #    git commit -m "My commit"
                                      #    git add *.c
                                      #    git mv file1 file2
                                      #    git commit --amend
commit --amend -m "Mes"               # Fires new commit message also
commit --amend --date="Web Feb 16 14:00 2011 +0100"
rebase -i HEAD~3                      # Interactive undo
reset HEAD file.rb                    # Removes file.rb from staged area
checkout -- file.rb                   # Reverts file changes
filter-branch --tree-filter 'rm -f passwords.txt' HEAD # Removes passwords.txt
                                      #    file from all commits
```

# Remote
```sh
remote                                # Shows configured remote servers
remote -v                             # Shows configured remote servers, verbose
remote add [name] [url]               # Adds new remote server
push [name]                           # Pushes to server with name=[name]
fetch [name]                          # Fetches from server with name=[name]
remote rename [name] [newname]        # Changes the name of the remote server
rm [name]                             # Removes server with name=[name]
```

## Tags
```sh
tag                                   # Lists tags
tag -l 'v1.2.*'                       # Finds a tag using wild-card
tag -a v1.2 -m 'Message'              # Adds an annotated tag v1.2
tag show v1.2                         # Shows this fucking tag
tag -s v1.2 -m 'Message'              # Tag with secret key to show
tag v1.2                              # Lightweight tag
push origin v1.5                      # Pushes tag to remote repo
push origin --tags                    # Pushes all tags
tag -d v1.5                           # Removes tag
```

## Branching
```sh
branch                                # Lists existed branches
branch -v                             # Lists existed branches with latest 
                                      #   commits
branch [name]                         # Creates new branch from current position
checkout [name]                       # Moves HEAD to branch with name=[name]
checkout -b [name]                    # Creates and moves to branch [name]

checkout -b 'hotfix'
add index.html
commit -m 'Fixed...'
checkout master
merge hotfix                          # Example of Fast Forwart merge
branch -d hotfix                      # Then we need to delete that branch

push [remote_serv] [branch_name]      # Pushes to remote server and branch
checkout -b serv origin/serv          # Now you can work on branch serv

rebase master server                  # Replays server work on top of master
checkout master
merge server
branch -d server
```

## On the server
```sh
instaweb --httpd=webrick --stop       # Runs web server locally
```

## Debugging
```sh
blame -L 12,22 myfile.rb              # Shows who and when have been changing
                                      #   each line of this file
bisect start                          # Binary search of bad commit
bisect bad
bisect good v1.0
bisect reset
bisect run test-error.sh              # Runs scripts that returns 0 if commit is
                                      #   good and non-0 if bad. This will
                                      #   detect bad commit in few minutes
```

## Submodules
```sh
submodule add git://github.com/chneukirchen/rack.git rack
submodule init                        # Inits .gitmodules file
submodule update                      # Fetches submodule files
```

## Attributes
```sh
.gitattributes                        # File to define git attributes
*.pbxproj binary                      # Treats file this files as binary
*.doc diff=word                       # Word filter for .doc binaries
*.png diff=exif                       # To diff images
config diff.exif.textconv exiftool    # Uses exiftool to compare images
database.xml merge=ours
```

## Hooks
```sh
# client-side hooks are located at .git/hooks directory
```


