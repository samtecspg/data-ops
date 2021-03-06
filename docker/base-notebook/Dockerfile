FROM pangeo/base-notebook:2020.11.06

LABEL maintainer="Kyle Prifogle <kprifogle1@gmail.com>"

SHELL ["conda", "run", "-n", "notebook", "/bin/bash", "-c"]
RUN conda env list

USER root

RUN apt-get update && apt-get install gcc python-dev libkrb5-dev -y

USER $NB_UID

RUN ${NB_PYTHON_PREFIX}/bin/pip install sparkmagic==0.15.0

RUN mkdir -p /home/$NB_USER/.sparkmagic
COPY sparkmagic/example_config.json /home/$NB_USER/.sparkmagic/config.json

RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension && \
    jupyter-kernelspec install --user $(pip show sparkmagic | grep Location | cut -d" " -f2)/sparkmagic/kernels/sparkkernel && \
    jupyter-kernelspec install --user $(pip show sparkmagic | grep Location | cut -d" " -f2)/sparkmagic/kernels/pysparkkernel && \
    jupyter serverextension enable --py sparkmagic

USER root
RUN chown $NB_USER /home/$NB_USER/.sparkmagic/config.json

# Misc
RUN mkdir -p /home/$NB_USER/notebooks && \
    chmod -R 777 /home/$NB_USER/notebooks

COPY entrypoint.sh /opt/
COPY singleuser-entrypoint.sh /opt/

# COPY notebooks /home/jovyan/notebooks/examples

# ENTRYPOINT ["tini", "-g", "--"]
CMD [ "/opt/entrypoint.sh" ]

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID
