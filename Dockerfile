FROM dockerfile/nodejs

# ==> videoconverter.js compilation toolchain
# ----------- Pre-reqs

RUN sudo apt-get install -y python-software-properties
RUN sudo apt-get install -y make
RUN sudo apt-get install -y curl
RUN sudo apt-get install -y git-core
RUN sudo apt-get install -y subversion
RUN sudo apt-get install -y cmake
RUN sudo apt-get install -y build-essential
RUN sudo apt-get install -y default-jre | iconv -f utf8 -t ascii//TRANSLIT

# ----------- LLVM

RUN cd ~ && svn co http://llvm.org/svn/llvm-project/llvm/tags/RELEASE_32/final llvm32
RUN cd llvm32/tools && svn co http://llvm.org/svn/llvm-project/cfe/tags/RELEASE_32/final clang
RUN cd llvm32/projects && svn co http://llvm.org/svn/llvm-project/compiler-rt/tags/RELEASE_32/final compiler-rt
RUN mkdir llvm32build
RUN cd llvm32build && cmake -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" -DLLVM_BUILD_EXAMPLES=OFF -DLLVM_INCLUDE_EXAMPLES=OFF -DLLVM_BUILD_TESTS=OFF -DLLVM_INCLUDE_TESTS=OFF ../llvm32
RUN cd llvm32build && make
RUN rm -rf ~/llvm32
RUN echo "export PATH=~/llvm32build/bin:\$PATH" >> .bashrc
#RUN source .bashrc
RUN clang --version

# ----------- Emscripten

RUN rm ~/.emscripten
RUN rm -rf ~/.emscripten_cache
RUN git clone https://github.com/kripken/emscripten.git
RUN cd ~/emscripten && git checkout master
RUN cd ~/emscripten && ./emcc --help
