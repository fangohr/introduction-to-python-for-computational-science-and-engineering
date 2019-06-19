FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y
RUN apt-get install -y python3
RUN apt-get install -y python3-dev
RUN apt-get install -y git
RUN apt-get install -y pandoc
# This is a big one. The missing executable was 'xelatex':
RUN apt-get install -y pandoc texlive-xetex
RUN apt-get install -y python3-pip
RUN pip3 install --upgrade pip
# need file for pandas chapter
RUN wget https://fangohr.github.io/data/eurostat/population2017/eu-pop-2017.csv
ADD eu-pop-2017.csv eu-pop-2017.csv
ADD requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
RUN mkdir -p /io
WORKDIR /io
CMD ["/bin/bash"]
