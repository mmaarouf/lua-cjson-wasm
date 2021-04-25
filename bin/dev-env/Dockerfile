FROM debian:bullseye-slim

RUN mkdir -p /usr/share/man/man1 && \
    apt update && \
    apt install  -y \
        neovim \
        git \
        python \
        openjdk-11-jdk

RUN echo "===Installing wasm===" && \
    git clone https://github.com/emscripten-core/emsdk.git && \
    cd emsdk &&\
    ./emsdk update-tags && \
    ./emsdk install latest && \
    ./emsdk activate latest && \
    echo "source /emsdk/emsdk_env.sh" >> ~/.bashrc

ENTRYPOINT ["bash", "-l"]
