FROM jupyter/datascience-notebook:latest

USER root

RUN apt-get update && apt-get install -y proj-bin libproj-dev libgeos-dev openssh-server libspatialindex-dev libpq-dev

USER $NB_UID

COPY requirements.txt /tmp/

RUN mkdir -p code/geoviz/ && chown -R jovyan:users /home/jovyan/code/ && chown -R jovyan:users /home/jovyan/code/geoviz

WORKDIR code/geoviz/

COPY --chown=jovyan:users . .

RUN pip install --requirement /tmp/requirements.txt && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

USER $NB_UID