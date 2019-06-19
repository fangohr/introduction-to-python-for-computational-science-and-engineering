FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get install -y python3 python3-dev \
    git pandoc wget python3-pip texlive-xetex

# ^tex-live is a big one. The missing executable was 'xelatex':

RUN pip3 install --upgrade pip
# need file for pandas chapter
ADD requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
RUN mkdir -p /io
WORKDIR /io
CMD ["/bin/bash"]
