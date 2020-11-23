FROM pangeo/base-notebook:2020.11.06

LABEL maintainer="Kyle Prifogle <kprifogle1@gmail.com>"

USER root

# Add JVM for spark stuff (ugh)
## following lines come from: https://hub.docker.com/r/picoded/ubuntu-openjdk-8-jdk/dockerfile/
RUN apt-get update && \
  apt-get install -y curl && \
	apt-get install -y openjdk-8-jdk && \
	apt-get install -y ant && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer;
	
# Fix certificate issues, found as of 
# https://bugs.launchpad.net/ubuntu/+source/ca-certificates-java/+bug/983302
RUN apt-get update && \
	apt-get install -y ca-certificates-java && \
	apt-get clean && \
	update-ca-certificates -f && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer;

# Setup JAVA_HOME, this is useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME



RUN apt-get update && apt-get install gcc python-dev libkrb5-dev -y

SHELL ["conda", "run", "-n", "notebook", "/bin/bash", "-c"]

RUN conda env list

USER $NB_UID

RUN ${NB_PYTHON_PREFIX}/bin/pip install sparkmagic==0.15.0

RUN mkdir -p /home/$NB_USER/.sparkmagic
COPY sparkmagic/example_config.json /home/$NB_USER/.sparkmagic/config.json

#more almond stuff (as above, mostly from https://almond.sh/docs/quick-start-install)
ENV SCALA_VERSION=2.12.8
ENV ALMOND_VERSION=0.10.0

RUN curl -Lo coursier https://git.io/coursier-cli && chmod +x coursier && ./coursier launch --fork almond:${ALMOND_VERSION} --scala ${SCALA_VERSION} -- --install

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
