#!/bin/bash

rm -rf gen/
mkdir -p gen/

JDK_VERSIONS="8 10"

for jdk in $JDK_VERSIONS; do
  mkdir -p gen/$jdk/
  cp -f src/* gen/$jdk/ 2> /dev/null
  cp -f src/$jdk/* gen/$jdk/ 2> /dev/null

  while read ln
  do
    echo ${ln//\$JDK_VERSION/$jdk}
  done < src/Dockerfile > gen/$jdk/Dockerfile
done

if [ "$1" == "push" ]; then
  REPOSITORY_ROOT=$(cd $(dirname $0)/.; pwd)
  git config --global user.name "Takeshi Mikami"
  git config --global user.email takeshi.mikami@gmail.com

  for jdk in $JDK_VERSIONS; do
    cd $REPOSITORY_ROOT/gen/$jdk
    echo $REPOSITORY_ROOT/gen/$jdk
    git init
    git remote add origin https://${GITHUB_ACCESS_TOKEN}@github.com/takemikami/docker-ideaic-inspect
    git checkout -b $jdk
    git add --all :/
    git commit -m "update docker build branch [ci skip]"
    git push origin $jdk --force
  done

  cd $REPOSITORY_ROOT
fi
