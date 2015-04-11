# Dockerized - Magento Community Edition 1.9.x

A dockerized version of "Magento Community Edition 1.9.x"

## Requirements

- [docker](http://docs.docker.com/compose/install/#install-docker)
- [docker-compose (formerly known as fig)](http://docs.docker.com/compose/install/#install-compose)

## Usage

```bash
./magento <action>
```

**Actons**

- **start**: Starts the docker containers (and triggers the installation if magento is not yet installed)
- **stop**: Stops all docker containers
- **restart**: Restarts all docker containers and flushes the cache
- **status**: Prints the status of all docker containers
- **magerun**: Executes magerun in the php container
- **destroy**: Stops all containers and removes all data

**Note**: The `magento`-script is just a small wrapper arround `docker-compose`. You can just use [docker-compose](https://docs.docker.com/compose/) directly.