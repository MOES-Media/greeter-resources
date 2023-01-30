FROM node:18-alpine

COPY --from=maven:3.8-eclipse-temurin-17-alpine /opt/java/openjdk /opt/java/openjdk
COPY --from=maven:3.8-eclipse-temurin-17-alpine /usr/share/maven /usr/share/maven

ENV JAVA_HOME=/opt/java/openjdk
ENV MAVEN_HOME=/usr/share/maven
ENV MAVEN_CONFIG=/root/.m2
ENV PATH="${JAVA_HOME}/bin:${MAVEN_HOME}/bin:${PATH}"

RUN java --version \
    && mvn -v

COPY --chown=node:node ./assets/ /var/assets
COPY --chown=node:node ./scripts/ /var/scripts

RUN chmod +x /var/scripts/entrypoint.sh

WORKDIR /workspace

ENTRYPOINT [ "/var/scripts/entrypoint.sh" ]
