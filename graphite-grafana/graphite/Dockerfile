FROM ubuntu:trusty

RUN apt-get update

# install usefull tools
RUN apt-get --no-install-recommends -y install \
                        # wget \
                        # openssh-server \
                        # openssh-sftp-server \
                        # openssh-client \
                        supervisor
                        # subversion \
                        # git

# install required packages for graphite
RUN apt-get --no-install-recommends -y install \
                        python-pip \
                        python-cairo \
                        python-dev \
                        python-django \
                        python-django-tagging \
                        python-twisted \
                        python-memcache \
                        python-pysqlite2 \
                        python-simplejson
# install nginx and uwsgi
RUN apt-get --no-install-recommends -y install \
                        nginx \
                        uwsgi-plugin-python \
                        uwsgi

# configure root user and ssh acess
RUN echo root:root | chpasswd
# RUN sed -i 's/^PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
#     mkdir /var/run/sshd && \
#     chmod 0755 /var/run/sshd

# install graphite
RUN pip install whisper carbon graphite-web

# configure grafite
RUN mkdir /opt/graphite/conf/examples && \
    mv /opt/graphite/conf/*.example /opt/graphite/conf/examples/ && \
    cp /opt/graphite/conf/examples/storage-schemas.conf.example /opt/graphite/conf/storage-schemas.conf && \
    cp /opt/graphite/conf/examples/storage-aggregation.conf.example /opt/graphite/conf/storage-aggregation.conf && \
    cp /opt/graphite/conf/examples/carbon.conf.example /opt/graphite/conf/carbon.conf && \
    cp /opt/graphite/conf/examples/graphite.wsgi.example /opt/graphite/conf/wsgi.py

ADD ./conf/local_settings.py /opt/graphite/webapp/graphite/
# ADD ./conf/nginx-graphite /etc/nginx/sites-available/graphite
ADD ./conf/uwsgi-graphite.ini /etc/uwsgi/apps-available/graphite.ini
ADD ./conf/nginx.conf /etc/nginx/
# Enable configs
# RUN ln -s /etc/nginx/sites-available/graphite /etc/nginx/sites-enabled/ && \
RUN ln -s /etc/uwsgi/apps-available/graphite.ini /etc/uwsgi/apps-enabled/

# create the local database for the webapp
RUN python /opt/graphite/webapp/graphite/manage.py syncdb --noinput && \
    echo "from django.contrib.auth.models import User; \
    User.objects.create_superuser('admin', 'admin@example.com', 'admin')" \
    | python /opt/graphite/webapp/graphite/manage.py shell

RUN chown -R www-data:www-data /opt/graphite/webapp/ /opt/graphite/storage/

# add supervisord config
ADD supervisord.conf /etc/

# RUN chmod u+x /run.sh

# graphite-api
EXPOSE 8080 \
# Carbon line receiver
2003



# CMD /run.sh
CMD supervisord
