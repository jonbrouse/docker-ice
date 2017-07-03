#!/bin/bash

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

update_version() {
  sed -i "/ENV\ ICE_VERSION/c\ENV\ ICE_VERSION\ $NEW_VERSION" ice/Dockerfile
  git commit ice/Dockerfile -m "Created new release: $NEW_VERSION"
  git tag -m "New version of ICE" "$NEW_VERSION.0"
}

upload_files() {
  git remote rm origin
  git remote add origin https://$GH_TOKEN@github.com/jonbrouse/docker-ice.git > /dev/null 2>&1
  git push --quiet --set-upstream origin master
  git push --tags
}

setup_git
update_version
upload_files
