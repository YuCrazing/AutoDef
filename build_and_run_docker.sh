# docker build --no-cache -t my-custom-ubuntu .
# docker build -t autodef-0 -f Dockerfile.0 .
docker build -t autodef-1 -f Dockerfile.1 .

# docker run -it autodef-1
# docker run -it --rm -v "$(pwd)":/AutoDef my-custom-ubuntu
# xhost +local:docker
docker run --gpus all -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix autodef-1
