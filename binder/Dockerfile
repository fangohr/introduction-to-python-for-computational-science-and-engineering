FROM python:3.7

#RUN apt-get update -y && apt-get install -y texlive-xetex latexmk texlive-xetex fonts-freefont-otf
RUN pip3 install --upgrade pip

COPY ../poetry.lock ../pyproject.toml /opt/

RUN pip install poetry==1.1.4

WORKDIR /opt/
RUN poetry config virtualenvs.create false
RUN poetry install -vvv

#
# Additions for use with Binder
#

# create user (for Binder, see
# https://mybinder.readthedocs.io/en/latest/tutorials/dockerfile.html#preparing-your-dockerfile)
ARG NB_USER=user
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
  --gecos "Default user" \
  --uid ${NB_UID} \
  ${NB_USER}

# copy notebooks in home directory of user (for Binder)
# Make sure the ipynb contents of our repo are in ${HOME}:
COPY book/* ${HOME}/
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

# start directory for binder
WORKDIR ${HOME}


# process to start
CMD ["/bin/bash"]
