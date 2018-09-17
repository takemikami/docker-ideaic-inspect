# docker-ideaic-inspect

prepare

```
./release.sh
```

build

```
cd gen/10
docker build . -t ideaic-inspect
```

run

```
docker run -i -v `pwd`:/project -v $HOME/.gradle:/root/.gradle -t ideaic-inspect /bin/bash
# cd /project
# mkdir -p report
# /opt/idea-IC/bin/inspect.sh `pwd`/build.gradle `pwd`/.idea/inspectionProfiles/Default.xml `pwd`/report -v2
```
