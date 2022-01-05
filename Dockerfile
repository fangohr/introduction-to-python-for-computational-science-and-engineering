FROM debian:bullseye-slim

RUN apt-get update -y && apt-get install -y texlive-xetex latexmk texlive-xetex \
	texlive-fonts-extra fonts-freefont-otf python3 python3-pip git zile wget

COPY poetry.lock pyproject.toml /opt/

RUN pip install poetry==1.1.4

WORKDIR /opt/
RUN poetry config virtualenvs.create false
RUN poetry install -vvv

RUN mkdir -p /io
WORKDIR /io

# Need this for one nbval and chapter 1
RUN ln -s /usr/bin/python3 /usr/local/bin/python

CMD ["/bin/bash"]
