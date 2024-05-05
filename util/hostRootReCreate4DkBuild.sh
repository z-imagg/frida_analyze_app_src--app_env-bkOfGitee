#!/usr/bin/env bash


_importBSFn "mkMyDirBySudo.sh"

#重建 供给docker build用的根目录
function hostRootReCreate4DkBuild() {
local HostTop="/hostTop"
local HostRoot="$HostTop/hostRoot"
local _app="$HostRoot/app"
#r_==real_
local r_app="/app"
sudo rm -fr $HostTop
mkMyDirBySudo $HostTop
mkMyDirBySudo $HostRoot
mkMyDirBySudo $_app 
# ln -s , ln -d 都被'docker build'拒绝 
#  rsync --progress
rsync  --quiet --fsync --recursive  $r_app/app_env $_app/
rsync  --quiet --fsync --recursive  $r_app/bash-simplify $_app/
}

hostRootReCreate4DkBuild