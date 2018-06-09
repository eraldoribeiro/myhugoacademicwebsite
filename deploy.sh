#!/bin/sh

echo "Generating static website files ..."
cd ~/Documents/website/myhugoacademicwebsite
hugo -d ~/Documents/website/eraldoribeiro.github.io/

echo "Pushing to publish"
cd ~/Documents/website/eraldoribeiro.github.io/
git add --all
git status
git commit -am "More changes"
git push origin master

echo "Updating the project files"
cd ~/Documents/website/myhugoacademicwebsite/
git add --all
git status
git commit -am "More changes"
git push origin master

