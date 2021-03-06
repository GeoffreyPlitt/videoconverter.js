
echo "Beginning Build:"

cd ffmpeg

emconfigure ./configure --cc="emcc" --disable-ffplay --disable-ffmpeg --disable-ffserver --disable-asm --enable-pic --disable-doc --disable-devices --disable-pthreads --disable-w32threads --disable-network --enable-small --disable-hwaccels --disable-parsers --disable-bsfs --disable-debug --disable-zlib
make clean;
emmake make;
emcc -O2 -s VERBOSE=1 -s ASM_JS=0 -s ALLOW_MEMORY_GROWTH=1 -v libavutil/*.o libavcodec/*.o libavformat/*.o libavdevice/*.o libswresample/*.o libavfilter/*.o libswscale/*.o *.o -o ../ffmpeg.js --pre-js ../ffmpeg_pre.js --post-js ../ffmpeg_post.js

cd ../

echo "Finished Build"