FROM debian:bullseye-slim

RUN apt-get update -y && apt-get install -y texlive-xetex latexmk texlive-xetex fonts-freefont-otf \
	python3 python3-pip git zile

COPY poetry.lock pyproject.toml /opt/

RUN pip install poetry==1.1.4

WORKDIR /opt/
RUN poetry config virtualenvs.create false
RUN poetry install -vvv

RUN mkdir -p /io
WORKDIR /io
CMD ["/bin/bash"]
