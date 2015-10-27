FROM phusion/passenger-full:latest
MAINTAINER Daniil Denishchenko <ddenyshchenko@intropro.com"


RUN rm -f /etc/service/nginx/down && \
    rm -f /etc/nginx/sites-enabled/default && \
    rm -f /etc/service/memcached/down

RUN ruby-switch --set ruby2.1 && gem install bundler

RUN groupadd openproject && \
    useradd -m -d /home/openproject --gid openproject openproject && \
    chown openproject:openproject /home/openproject && \
    echo openproject:openproject | chpasswd

RUN echo root:root | chpasswd
ENV HOME /root

ADD configs/webapp.conf /etc/nginx/sites-enabled/webapp.conf
ADD configs/mysql-env.conf /etc/nginx/main.d/postgres-env.conf

USER openproject
WORKDIR /home/openproject
ENV HOME /home/openproject

RUN git clone https://github.com/opf/openproject.git


WORKDIR /home/openproject/openproject

RUN git checkout stable


RUN bundle install --path vendor/bundle
RUN npm install


ADD configs/configuration.yml /home/openproject/openproject/config/configuration.yml
ADD configs/database.yml /home/openproject/openproject/config/database.yml


RUN bundle exec rake generate_secret_token

ENV RAILS_ENV="production"

RUN sed -i 's/config.serve_static_assets = false/config.serve_static_assets = true/' /home/openproject/openproject/config/environments/production.rb
RUN sed -i '101i    I18n.enforce_available_locales = false' /home/openproject/openproject/config/application.rb
RUN touch /home/openproject/first.status

USER root

ADD scripts/initialize.sh /home/openproject/
RUN chown openproject:openproject /home/openproject/initialize.sh
ADD scripts/start.sh /home/openproject/

VOLUME ["/home/openproject/"]

WORKDIR /home/openproject

CMD [ "sh","-c","/home/openproject/start.sh" ]
