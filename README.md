# Infrastructure "Big Bang"

## About

This project was created to build a "big bang" container that would create a
basic infrastructure on AWS for a cloud project.

## How to build

Simply run the ```build.sh``` script on a machine with Docker installed. That
will create a new Docker image named 'infra-big-bang'.

## How to run

To initialize the "Big Bang", run the container as follows:

```$ docker run -it --rm infra-big-bang```

Optionally, you can set AWS variables using:

```$ docker run -it --rm -e AWS_ACCESS_KEY_ID=AKIA1NOT2A3VALID4KEY -e AWS_SECRET_ACCESS_KEY=willN0tPut4nyth1ngV4l1dHere3ither0123456 infra-big-bang```
