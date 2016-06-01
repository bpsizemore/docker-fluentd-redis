FROM fluent/fluentd
MAINTAINER bpsizemore@gmail.com

USER root
RUN mkdir /etc/fluent
ADD fluent.conf /etc/fluent/

RUN mkdir /etc/fluent/gems
ADD gems /etc/fluent/gems
RUN for gem in $(ls /etc/fluent/gems/); do gem install /etc/fluent/gems/$gem; done


RUN ["gem", "install", "fluent-plugin-redis-store"]
RUN ["gem", "install", "fluent-plugin-record-reformer", "--no-rdoc", "--no-ri"]
RUN ["gem", "install", "fluent-plugin-docker_metadata_filter"]
RUN ["gem", "install", "fluent-plugin-record-modifier"]
RUN ["gem", "install", "fluent-plugin-rename-key"]
RUN ["gem", "install", "fluent-plugin-grep"]
ENTRYPOINT ["fluentd", "-c", "/etc/fluent/fluent.conf", "-qq"]
