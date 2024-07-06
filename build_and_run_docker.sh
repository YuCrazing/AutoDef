# docker build --no-cache -t my-custom-ubuntu .
docker build -t autodef .
# docker run -it autodef
# docker run -it --rm -v "$(pwd)":/AutoDef my-custom-ubuntu

xhost +local:docker
docker run -it \
    --env="DISPLAY" \
    --env="LIBGL_ALWAYS_INDIRECT=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    autodef