FROM rootproject/root:latest
  
WORKDIR /work

RUN apt update
RUN apt -y install python3-pip vim screen emacs
RUN python3 -m pip install --upgrade pip setuptools wheel
RUN python3 -m pip install jupyter scipy uproot root-numpy matplotlib recordtype lmfit pandas jupyterhub

RUN apt-get update && apt-get install -yq --no-install-recommends \
    build-essential \
    ca-certificates \
    locales \
    python3-dev \
    python3-pip \
    python3-pycurl \
    nodejs \
    npm \
    sssd-common \
    libnss-sss \
    libpam-sss \
    sudo && apt-get clean

RUN npm install -g configurable-http-proxy@^4.2.0 && rm -rf ~/.npm

RUN mkdir /etc/jupyterhub && jupyterhub --generate-config -f /etc/jupyterhub/jupyterhub_config.py

RUN mkdir /storage

EXPOSE 8000

ENTRYPOINT ["jupyterhub"]
CMD ["-f", "/etc/jupyterhub/jupyterhub_config.py"]

