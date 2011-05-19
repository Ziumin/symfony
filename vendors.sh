#!/bin/sh

cd $(dirname $0)

# initialization
if [ "$1" = "--reinstall" ]; then
    rm -rf vendor
fi

mkdir -p vendor && cd vendor

##
# @param destination directory (e.g. "doctrine")
# @param URL of the git remote (e.g. git://github.com/doctrine/doctrine2.git)
# @param revision to point the head (e.g. origin/HEAD)
#
install_git()
{
    INSTALL_DIR=$1
    SOURCE_URL=$2
    REV=$3

    if [ -z $REV ]; then
        REV=origin/HEAD
    fi

    if [ ! -d $INSTALL_DIR ]; then
        git clone $SOURCE_URL $INSTALL_DIR
    fi

    cd $INSTALL_DIR
    git fetch origin
    git reset --hard $REV
    cd ..
}

# Assetic
install_git assetic git://github.com/kriswallsmith/assetic.git

# Doctrine ORM
install_git doctrine git://github.com/doctrine/doctrine2.git 2.0.5

# Doctrine DBAL
install_git doctrine-dbal git://github.com/doctrine/dbal.git 2.0.5

# Doctrine Common
install_git doctrine-common git://github.com/doctrine/common.git origin/3.0.x

# Doctrine migrations
install_git doctrine-migrations git://github.com/doctrine/migrations.git

# Monolog
install_git monolog git://github.com/Seldaek/monolog.git

# Swiftmailer
install_git swiftmailer git://github.com/swiftmailer/swiftmailer.git origin/4.1

# Twig
install_git twig git://github.com/fabpot/Twig.git
