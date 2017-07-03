#!/bin/bash

timestamp() {
  echo $(date +%b\ %d\ %T) $*
}

setup_git() {
  timestamp Setting up git config...
  git config --global push.default matching
  git config --global user.email "jbrouse19@gmail.com"
  git config --global user.name "Jon Brouse"
  git remote rm origin
  git remote add origin https://$GH_TOKEN@github.com/jonbrouse/docker-ice.git > /dev/null 2>&1
}

update_ice_version() {
  timestamp Updating Dockerfile and commiting...
  sed -i "/ENV\ ICE_VERSION/c\ENV\ ICE_VERSION\ $NEW_VERSION" ice/Dockerfile
  git commit ice/Dockerfile -m "Updated Ice version to $NEW_VERSION"
}

update_master() {
  timestamp Committing to master...
  git checkout -b temp
  git branch -f master temp
  git push origin master
}

create_new_tag() {
  timestamp Creating release tag...
  git tag -m "New version of ICE" "$NEW_VERSION.0"
  git push --quiet --set-upstream origin
  git push --tags
}

setup_git
update_ice_version
update_master
create_new_tag
