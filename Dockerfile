# Use the official Ubuntu image as a base
# FROM ubuntu:latest
FROM my-custom-ubuntu:latest

RUN extern/anaconda/bin/pip install --upgrade pip
RUN extern/anaconda/bin/pip install --upgrade pip
RUN extern/anaconda/bin/pip install protobuf==3.4.0
RUN extern/anaconda/bin/pip install extern/tensorflow_cc/tensorflow_cc/build/tensorflow/pip_package_build/tensorflow-1.8.0-cp36-cp36m-linux_x86_64.whl



# Install Keras
RUN extern/anaconda/bin/pip install keras==2.0.8 

# Now I need to set the default in keras
RUN mkdir ~/.keras/; exit 0
RUN cp ./keras.json ~/.keras/


### Now the rest of the related code
# remove the author's GAUSS
RUN rm -rf extern/GAUSS/
# clone Eric's GAUSS recursively
WORKDIR /AutoDef/extern
RUN git clone --recursive https://github.com/ericchen321/GAUSS.git
# Build GAUSS
WORKDIR /AutoDef/extern/GAUSS/
RUN bash InstallGAUSS_Ubuntu_noqt.sh
WORKDIR /AutoDef

# Build Libigl Python bindings
RUN rm -rf extern/libigl/
RUN git clone -b AutoDef --recursive  https://github.com/lawsonfulton/libigl-legacy.git extern/libigl
WORKDIR /AutoDef/extern/libigl/python
RUN mkdir build
WORKDIR /AutoDef/extern/libigl/python/build
RUN cmake ..
RUN make -j8
WORKDIR /AutoDef

# Build nlohmann's json
RUN rm -rf extern/json/
RUN git clone --recursive https://github.com/nlohmann/json.git extern/json/
WORKDIR /AutoDef/extern/json/
RUN git reset --hard 9294e25










# Set environment variables to avoid prompts during the installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install necessary packages
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    libgl1-mesa-dev \
    mesa-utils \
    libglu1-mesa-dev \
    freeglut3-dev \
    x11-apps \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables for OpenGL
ENV LIBGL_ALWAYS_INDIRECT=1

# Verify OpenGL installation
RUN glxinfo | grep "OpenGL"; exit 0


RUN apt-get install libglu1-mesa-dev
# Build Cubacode
WORKDIR /AutoDef/src/cubacode
RUN mkdir build
WORKDIR /AutoDef/src/cubacode/build
RUN cmake ..
RUN make -j8; exit 0
# WORKDIR /AutoDef


# Set the default command to run when the container starts
CMD ["bash"]