FROM fr3akyphantom/droid-builder:focal

RUN sudo apt-get update -q && \
    sudo apt-get upgrade -yq
