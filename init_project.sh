#!/usr/bin/env bash

read -p 'Enter the project name: ' name

if [ -d '.vagrant' ]; then
	vagrant destroy --force > /dev/null 2>&1
	rm -rf .vagrant
fi

mv project_name $name

sed -i.bak "s/project_name/$name/" vagrant/setup.sh
sed -i.bak "s/project_name/$name/" .gitignore
sed -i.bak "s/project_name/$name/" manage.py
sed -i.bak "s/project_name/$name/" $name/wsgi.py
sed -i.bak "s/project_name/$name/" $name/settings/settings.py

find . -name "*.bak" -exec rm -rf {} \;
rm init_project.sh

echo 'Done.'
