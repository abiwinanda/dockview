# Dockview

To build the docker image you can run

```sh
docker build -t dockview .
```

this will create an image called `dockview:latest`.

To start a container from the image run

```sh
docker container run -p 4000:4000 --name dockviewcon -d dockview
```

The command will run a container called `dockviewcon` with a detach mode (i.e running in the background) using the image `dockview`. The container will be accessible through localhost port `4000`.

## Reference

- https://blog.miguelcoba.com/deploying-a-phoenix-16-app-with-docker-and-elixir-releases
