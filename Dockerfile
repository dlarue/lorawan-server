FROM erlang:19
MAINTAINER Petr Gotthard <petr.gotthard@centrum.cz>

RUN apt-get update && apt-get install -y git npm && rm -r /var/cache/
RUN git clone https://github.com/gotthardp/lorawan-server.git && cd lorawan-server && rebar3 release && rm -r node_modules

# volume for the mnesia database and logs
RUN mkdir /storage
VOLUME /storage

# data from port_forwarders
EXPOSE 1680/udp
# admin interface
EXPOSE 8080/tcp

ENV LORAWAN_HOME=/storage
WORKDIR /lorawan-server/_build/default/rel/lorawan-server
CMD bin/lorawan-server
