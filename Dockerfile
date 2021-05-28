FROM openjdk:8@sha256:fcb55896a657774a1d0ad08da5dd4875c7947ead4838e971b8e8fc7fcc9fe5b4

LABEL maintainer="Atomist <docker@atomist.com>"

ENV DUMB_INIT_VERSION=1.2.2

RUN curl -s -L -O https://github.com/Yelp/dumb-init/releases/download/v$DUMB_INIT_VERSION/dumb-init_${DUMB_INIT_VERSION}_amd64.deb     && dpkg -i dumb-init_${DUMB_INIT_VERSION}_amd64.deb     && rm -f dumb-init_${DUMB_INIT_VERSION}_amd64.deb

RUN mkdir -p /app

WORKDIR /app

EXPOSE 8080

CMD ["-jar", "cd-spring-11.jar"]

ENTRYPOINT ["dumb-init", "java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-Xmx256m", "-Djava.security.egd=file:/dev/urandom"]

COPY target/cd-spring-11.jar cd-spring-11.jar
