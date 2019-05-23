ARG BASE_CONTAINER=jupyter/scipy-notebook
FROM $BASE_CONTAINER

LABEL  maintainer "dangnh <hikariraina@gmail.com>"

# Install Tensorflow
RUN conda install --quiet --yes \
    'pydot' \
    'tensorflow=1.13*' \
    'keras=2.2*' && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN pip --no-cache-dir install gym
USER root
RUN sudo apt-get update
RUN sudo apt-get -y install graphviz
RUN sudo rm -rf /var/lib/apt/lists/*

RUN pip install jupyterlab
RUN jupyter serverextension enable --py jupyterlab

