DIRLIST="
ssh
vim
chef
"

FILELIST="
gemrc
vimrc
bashrc
bash_profile
gitignore
gitconfig
git-completion.bash
hgrc
screenrc
"

DOTFILE_DIR=`pwd`

if [ ! -e $DOTFILE_DIR/old_files ]; then

echo "Moving old files to $DOTFILE_DIR"
    mkdir $DOTFILE_DIR/old_files
    for DIR in ${DIRLIST};
    do
        mv ~/.${DIR} $DOTFILE_DIR/old_files/
    done
    for FILE in ${FILELIST};
    do
        mv ~/.${FILE} $DOTFILE_DIR/old_files/
    done

echo "Linking Directories and Files"
    for FILE in ${FILELIST};
    do
        ln -s $DOTFILE_DIR/${FILE} ~/.${FILE}
    done
    for DIR in ${DIRLIST};
    do
        ln -s $DOTFILE_DIR/${DIR} ~/.${DIR}
    # this removes the self-ln from above
        rm ~$DOTFILE_DIR/${DIR}/${DIR}
    done
    echo "go install exuberant-ctags!"
    #sudo apt-get install exuberant-ctags
else
    echo "$DOTFILE_DIR/oldfiles exists, please clean up before running"
fi

# and submodules
git submodule update --init
git submodule foreach git pull origin master
git submodule foreach git submodule update --init
