vimrc of record resides in %homepath%\vimfiles\vimrc
to make sure vsvim also picks this up simply edit %homepath%\_vimrc to
contain:
source $userprofile\vimfiles\vimrc


Also, vimrc sets backupdir, undodir, and directory to directories that need
to be cerated at ~/vimback, vimundo, and vimswap respectively
