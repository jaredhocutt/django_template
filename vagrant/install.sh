#!/usr/bin/env bash

###############################################################################
# General
###############################################################################

apt-get install -y software-properties-common

###############################################################################
# PostgreSQL
###############################################################################

echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
apt-get update

apt-get install -y postgresql-9.4 postgresql-server-dev-9.4

service postgresql restart
update-rc.d postgresql defaults

###############################################################################
# Python
###############################################################################

apt-get install -y python-pip python-dev

pip install virtualenvwrapper
