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

# Deployment

Start a Docker container 'pyroot-notebook' in background on local port 8888

```
docker run -p 8888:8000 -d --name pyroot-notebook gtortone/dsproto-jupyterhub
```
