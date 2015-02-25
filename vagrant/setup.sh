#!/usr/bin/env bash

###############################################################################
# PostgreSQL
###############################################################################

cd /tmp  # Prevent "cannot change to directory" messages
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'postgres';"
sudo -u postgres psql -c "CREATE DATABASE project_name;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE project_name TO postgres;"

###############################################################################
# Python Virtual Environment
###############################################################################

source /usr/local/bin/virtualenvwrapper.sh

mkvirtualenv project_name

echo "/vagrant" > $VIRTUAL_ENV/.project

cat >>$VIRTUAL_ENV/bin/postactivate <<EOF
export PYTHONPATH=.:/vagrant
export DJANGO_SETTINGS_MODULE=project_name.settings.dev
EOF

deactivate

###############################################################################
# App
###############################################################################

workon project_name

if [ ! -e "/vagrant/project_name/settings/dev.py" ]
then
	echo 'from settings import *' > /vagrant/project_name/settings/dev.py
fi

pip install -r requirements.txt

python manage.py migrate

cat >>/home/vagrant/.bashrc <<"EOF"
source /usr/local/bin/virtualenvwrapper.sh

if [[ $(python -c "import sys; print hasattr(sys, 'real_prefix')") == "False" ]]
then
	workon project_name
fi

alias runserver="/home/vagrant/.virtualenvs/project_name/bin/python /vagrant/manage.py runserver 0.0.0.0:8000"
EOF
