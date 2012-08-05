#!/bin/bash
################################################################################
# Date:     2011/04/18
# Author:   appleboy ( appleboy.tw AT gmail.com)
# Web:      http://blog.wu-boy.com
# modified: 2012/07/20
#
# Program:
#   Install all Ubuntu program automatically
#
################################################################################

function usage()
{
    echo 'Usage: '$0' [--help|-h] --install [server|desktop|initial|all]'
    exit 1;
}

function displayErr()
{
    echo
    echo $1;
    echo
    exit 1;
}

function initial()
{
    # update package and upgrade Ubuntu
    apt-get -y update && apt-get -y upgrade
    # terminal-based package manager (terminal interface only)
    apt-get -y install aptitude
}

function server()
{
    # install Ubuntu PPA
    add-apt-repository -y ppa:nginx/stable

    aptitude -y install openssh-server
    aptitude -y install build-essential
    aptitude -y install git
    aptitude -y install subversion
    aptitude -y install bison
    aptitude -y install flex
    aptitude -y install gettext
    aptitude -y install g++
    aptitude -y install libncurses5-dev
    aptitude -y install libncursesw5-dev
    aptitude -y install exuberant-ctags
    aptitude -y install sharutils
    aptitude -y install help2man
    aptitude -y install zlib1g-dev libssl-dev
    aptitude -y install gawk
    aptitude -y install libid3tag0-dev
    aptitude -y install libgdbm-dev
    aptitude -y install xinetd nfs-kernel-server minicom build-essential libncurses5-dev uboot-mkimage autoconf automake
    aptitude -y install qt4-make

    # install git from kernel git://git.kernel.org/pub/scm/git/git.git
    aptitude -y install libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev

    # git core
    aptitude -y install git-core git-doc git-gui

    # mkpasswd command
    aptitude -y install whois

    # vim
    aptitude -y install vim

    # apache mpm worker mod_fcgid
    aptitude -y install apache2.2-bin apache2.2-common apache2-mpm-worker libapache2-mod-fcgid php5-cli php5-cgi php5-common
    aptitude -y install apache2 php5 php5-gd php5-curl php5-fpm

    # php xdebug
    aptitude -y install php5-dev
    aptitude -y install php-pear
    pecl install xdebug

    # install nginx web server
    aptitude -y install nginx

    # install mysql server and phpmyadmin
    aptitude -y install mysql-server phpmyadmin

    # man program
    aptitude -y install most

    # version tool: subversion program
    aptitude -y install subversion

    # grep-like program specifically for large source trees
    aptitude -y install ack-grep

    # install ruby
    aptitude -y install ruby rake rubygems

    # install mercurial
    aptitude -y install mercurial

    # install ffmpeg
    aptitude -y install ffmpeg

    # install irssi
    aptitude -y install irssi

    # install python easy_install
    aptitude -y install python-pip

    # install terminal multiplexer (http://tmux.sourceforge.net/)
    aptitude -y install tmux

    # install ImageMagic
    aptitude -y install imagemagick

    # update rubygems
    gem install rubygems-update
    update_rubygems

    # install compass tool and livereload
    gem install compass
    gem install guard-livereload

    # install PPA purge command
    aptitude -y install ppa-purge

    # remove nfs and rpcbind
    aptitude -y --purge remove nfs-common
    aptitude -y --purge remove rpcbind

    # install cpanm before install Vimana
    wget --no-check-certificate http://xrl.us/cpanm -O /usr/bin/cpanm
    chmod 755 /usr/bin/cpanm
    cpanm Vimana
}

function desktop()
{
    # install Ubuntu PPA
    add-apt-repository -y ppa:webupd8team/sublime-text-2
    add-apt-repository -y ppa:geany-dev/ppa
    add-apt-repository -y ppa:pidgin-developers/ppa
    add-apt-repository -y ppa:amsn-daily/ppa

    # Installer for Microsoft TrueType core fonts
    aptitude -y install ttf-mscorefonts-installer
    aptitude -y purge ttf-mscorefonts-installer ubuntu-restricted-extras

    # program tool: geany
    aptitude -y install geany

    # pidgin + msn-pecan
    aptitude -y install pidgin msn-pecan

    # aMSN
    # ref: https://launchpad.net/~amsn-daily/+archive/ppa
    aptitude -y install aMSN

    # filezilla
    aptitude -y install filezilla

    # PCMan
    aptitude -y install pcmanx-gtk2

    # graphical tool to diff and merge files
    aptitude -y install meld

    # install java enviriment
    aptitude -y install sun-java6-jre sun-java6-plugin sun-java6-fonts

    # install adobe flash plugin
    aptitude -y install flashplugin-installer

    # install mp3 easytag
    aptitude -y install easytag

    # install mp3 player
    aptitude -y install exaile

    # install multiget (http://multiget.sourceforge.net/)
    aptitude -y install multiget

    # install 7zip
    aptitude -y install p7zip-full

    # install smplayer
    aptitude -y install smplayer

    # install hime (http://hime.luna.com.tw/)
    aptitude -y install hime im-config

    # install gcin
    aptitude -y install gcin
    # http://ahhafree.blogspot.tw/2011/11/gcin.html
    gsettings set com.canonical.Unity.Panel systray-whitelist "['all']"

    # install google chrome browser
    aptitude -y install google-chrome-stable

    # install sublime-text editor
    aptitude -y install sublime-text
}

# Process command line...
while [ $# -gt 0 ]; do
    case $1 in
        --help | -h)
            usage $0
        ;;
        --install) shift; action=$1; shift; ;;
        *) usage $0; ;;
    esac
done

if [ "`whoami`" != "root" ] ; then
    displayErr "You are not root, please execute sudo su - command"
fi

test -z $action && usage $0

case $action in
    "desktop")
        initial
        desktop
        ;;
    "server")
        initial
        server
        ;;
    "initial")
        initial
        ;;
    "all")
        initial
        server
        desktop
        ;;
    *)
        usage $0
        ;;
esac
exit 1;
