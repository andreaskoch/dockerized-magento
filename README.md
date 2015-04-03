# Dockerized - Magento Community Edition 1.9.x

A dockerized version of "Magento Community Edition 1.9.x"

## Requirements

- PHP and Composer for the installation of Magento
- [docker](http://docs.docker.com/compose/install/#install-docker)
- [docker-compose](http://docs.docker.com/compose/install/#install-compose)

## Usage

```bash
docker-compose up -d
```

## Installation (as a service)

You can start the project using the default fig commands or you can install and init.d script.

**Create an init.d script**

```bash
sudo ln -s $(readlink -f ./service.sh) /etc/init.d/magento-ce-1-9
```

**Enable autostart**

On Debian/Ubuntu:

```bash
sudo update-rc.d magento-ce-1-9 defaults
```

On RHEL/CentOS:

```bash
sudo chkconfig magento-ce-1-9 on
```
