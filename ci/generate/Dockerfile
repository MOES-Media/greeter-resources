FROM node:16-alpine AS node
FROM bufbuild/buf:1.8.0

RUN apk update && apk add --no-cache make \
    protobuf-dev libc6-compat libstdc++ gcompat \
    wget

COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/share /usr/local/share
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin

RUN npm i -g --unsafe-perm grpc-tools@1.11.1 grpc_tools_node_protoc_ts@5.0.1

COPY --from=golang:alpine /usr/local/go/ /usr/local/go/
COPY --from=pseudomuto/protoc-gen-doc:latest /usr/bin/protoc-gen-doc /usr/bin/protoc-gen-doc

RUN mkdir -p ${HOME}/tools/java
RUN wget -O ${HOME}/tools/java/protoc-gen-grpc-java \
    https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.50.2/protoc-gen-grpc-java-1.50.2-linux-x86_64.exe
RUN chmod +x ${HOME}/tools/java/protoc-gen-grpc-java

ENV PATH="/usr/local/go/bin:/usr/bin/protoc-gen-doc:${PATH}"

WORKDIR /workspace
