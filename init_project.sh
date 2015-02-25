#!/usr/bin/env bash

read -p 'Enter the project name: ' name

if [ -d '.vagrant' ]; then
	vagrant destroy --force
	rm -rf .vagrant
fi

mv project_name $name

sed "s/project_name/$name/" vagrant/setup.sh > vagrant/setup.sh
sed "s/project_name/$name/" .gitignore > .gitignore
sed "s/project_name/$name/" manage.py > manage.py
sed "s/project_name/$name/" $name/wsgi.py > $name/wsgi.py

rm init_project.sh

echo 'Done.'
