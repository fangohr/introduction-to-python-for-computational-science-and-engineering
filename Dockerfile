FROM python:3.7

WORKDIR /work/

COPY . /work/

RUN pip install poetry==1.1.4

RUN make install

RUN make all
