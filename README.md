# cuda-opencv
Dockerfile for building/adding opencv to cuda9.1 image

to build:

```docker build -t awokeknowing/cuda-opencv -t awokeknowing/cuda-opencv:cuda9.1-cudnn7-cv3.4 .```


to run (though it's actually intended as a base image for adding some other application or framework:

```docker run --runtime=nvidia --rm -it awokeknowing/cuda-opencv```
