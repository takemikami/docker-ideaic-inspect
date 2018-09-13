#!/bin/sh

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

  for jdk in $JDK_VERSIONS; do
    cd $REPOSITORY_ROOT/gen/$jdk
    echo $REPOSITORY_ROOT/gen/$jdk
    git init
    git remote add origin git@github.com:takemikami/docker-ideaic-inspect.git
    git checkout -b $jdk
    git add --all :/
    git commit -m "[auto] docker build branch"
    git push origin $jdk --force
  done

  cd $REPOSITORY_ROOT
fi
