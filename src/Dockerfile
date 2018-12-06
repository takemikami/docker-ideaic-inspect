FROM openjdk:$JDK_VERSION-jdk

RUN curl -O -sS -L https://download.jetbrains.com/idea/ideaIC-2018.3.1-no-jdk.tar.gz \
  && mkdir -p /opt \
  && tar zxf ideaIC-2018.3.1-no-jdk.tar.gz -C /opt \
  && ln -s /opt/`ls /opt | grep idea-IC | sort -r | head -1` /opt/idea-IC \
  && rm -rf ideaIC-2018.3.1-no-jdk.tar.gz

COPY /jdk.table.xml /root/.IdeaIC2018.3/config/options/jdk.table.xml
