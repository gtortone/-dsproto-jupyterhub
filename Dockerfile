FROM rootproject/root:latest
  
WORKDIR /work

RUN apt update
RUN apt -y install python3-pip vim screen emacs
RUN python3 -m pip install --upgrade pip setuptools wheel
# After October 2020 errors can happen when installing or updating packages. Pip will change the way that it resolves dependency conflicts.
# recommend use --use-feature=2020-resolver to test your packages with the new resolver before it becomes the default.
RUN python3 -m pip --use-feature=2020-resolver install jupyter scipy uproot root-numpy matplotlib recordtype lmfit pandas jupyterhub
RUN python3 -m pip --use-feature=2020-resolver install numericalunits numba lz4 cython mpmath sympy astropy keras sklearn tables

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

