# TOOLS
Handy Tools and Scripts


-------------------
setenv.sh
-------------------
# Persistent alias script for Commands and Directory Paths
I created this script to create aliases when in labs to reduce typing ...

## alias Removal:
you will need to remove the aliases set by editing the .*rc file or overwriting the alias by using the same alias again 
I use same aliases for specific uses so it helps me alot ..
you can NOT use 'unalias' command.

## Shell detection
this script detects the  login shell using $SHELL on both "/bin/" and "/usr/bin" paths automatically.

## Scope
the changes made will be limited to the login Shell  --  any sub shells spawned will not be able to use the aliases created.

------------------