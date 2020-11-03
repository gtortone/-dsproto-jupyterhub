# dsproto-jupyterhub
Jupyterhub image with ROOT from rootproject/root:latest for Darkside Python reconstruction tasks

Included Python libraries:

- scipy 
- uproot 
- root-numpy
- matplotlib 
- recordtype 
- lmfit
- pandas
- numericalunits
- numba
- lz4
- cython
- mpmath
- sympy
- astropy 
- keras 
- sklearn

# Deployment

### Configuration

To share users between hosting machine and container SSSD (https://sssd.io/) can be used.

- Install SSSD
```
yum install sssd
```

- Configure SSSD

in /etc/pam.d/sss_proxy

```
auth required pam_unix.so
account required pam_unix.so
password required pam_unix.so
session required pam_unix.so
```

- in /etc/sssd/sssd.conf

```
[sssd]
services = nss, pam
config_file_version = 2
domains = proxy
[nss]
[pam]
[domain/proxy]
id_provider = proxy
# The proxy provider will look into /etc/passwd for user info
proxy_lib_name = files
# The proxy provider will authenticate against /etc/pam.d/sss_proxy
proxy_pam_target = sss_proxy
```

- set permissions
```
chmod 0600 /etc/sssd/sssd.conf
```

- enable at boot
```
systemctl enable sssd
```

### Container

#### Start JupyterHub Docker container in background on local port 8888 and use SSSD sockets to share host machine users

```
docker run -it -d -p 8888:8000 -v /var/lib/sss/pipes/:/var/lib/sss/pipes/:rw --name jupyterhub gtortone/dsproto-jupyterhub
```

#### Bind host machine /home and /storage directories

```
docker run -it -d -p 8888:8000 -v /var/lib/sss/pipes/:/var/lib/sss/pipes/:rw -v /home:/home -v /storage:/storage --name jupyterhub gtortone/dsproto-jupyterhub
```

#### Start JupyterHub Docker container with SSL support
```
docker run -it -d -p 443:443 -v /var/lib/sss/pipes/:/var/lib/sss/pipes/:rw -v /home:/home -v /storage:/storage --name jupyterhub gtortone/dsproto-jupyterhub
```
- copy in /etc/jupyterhub SSL certificate (cert.pem) and SSL key (cert.key)

- edit /etc/jupyterhub/jupyterhub_config.py

