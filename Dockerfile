FROM python:3.7

RUN apt-get update -y && apt-get install -y texlive-xetex
RUN pip3 install --upgrade pip

COPY poetry.lock pyproject.toml /opt/

RUN pip install poetry==1.1.4

WORKDIR /opt/
RUN poetry config virtualenvs.create false
RUN poetry install -vvv

RUN mkdir -p /io
WORKDIR /io
CMD ["/bin/bash"]
