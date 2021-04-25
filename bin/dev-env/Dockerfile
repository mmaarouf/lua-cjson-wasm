FROM debian:bullseye-slim

RUN mkdir -p /usr/share/man/man1 && \
    apt update && \
    apt install  -y \
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

# Installing lua dependencies
RUN apt install -y \
      lua5.1 \
      luarocks && \
    luarocks install lua-cjson && \
    luarocks install busted && \
    wget -c https://www.lua.org/ftp/lua-5.1.5.tar.gz -O - | tar -xz && \
    git clone https://github.com/openresty/lua-cjson.git

ENTRYPOINT ["bash", "-l"]
