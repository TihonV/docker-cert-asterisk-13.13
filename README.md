# docker-cert-asterisk-13.13
Dockerfile for building [Asterisk][github/asterisk].

This Dockerfile currently builds Centos "7" release.  It configures Asterisk "13.13-cert-2"  
using the configs from `asterisk/configs/samples`.

## USAGE

### Building

To build this image, just clone the repo and build using docker:

    git clone https://github.com/respoke/asterisk-docker.git
    cd asterisk-docker
    docker build -t asterisk .

### Running

    docker run -d -it -v $YOUR_ETC_ASTERISK/:/etc/asterisk/:Z -v $YOUR_LOGS_DIR/:/var/log/asterisk/:Z asterisk

### Connect to container

    docker exec -it container_name asterisk -rvvvvvv

# license

[MIT](https://github.com/respoke/asterisk-docker/blob/master/LICENSE)

[github/asterisk]: https://github.com/asterisk/asterisk
[dockerhub/asterisk]: https://hub.docker.com/r/respoke/asterisk/
[Official Jinja2 Template Designer Documentation]: http://jinja.pocoo.org/docs/dev/templates/
