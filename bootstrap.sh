#!/usr/bin/env bash

git pull origin main;
git submodule update --init --recursive;

function copyFiles() {
	rsync --exclude ".git/" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		-avh --no-perms . ~;
}

read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
    copyFiles;
    echo "Files copied successfully. Now you can re-login.";
fi;
