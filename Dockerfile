FROM debian:wheezy
RUN apt-get update && apt-get upgrade -y && \
 apt-get install -y --force-yes \
  git-core \
  python python-setuptools python-dev libpq-dev && \
 apt-get autoremove -y && \
 apt-get clean
RUN easy_install pip && \
  pip install virtualenv \
    django && \
  pip install python-openid \
    python-debian \
    South \
    poster \
    simplejson && \
  pip install -Iv \
    https://github.com/celery/celery/archive/v2.2.7.tar.gz && \
  pip install django-openid-auth \
    django-celery \
#    django-pickfield \
    django-debug-toolbar
RUN git clone git://github.com/yht/python-irgsh.git /opt/irgsh
RUN git clone git://github.com/yht/irgsh-web.git /opt/irgsh-web
RUN git clone git://github.com/yht/irgsh-node.git /opt/irgsh-node
RUN git clone git://github.com/yht/irgsh-repo.git /opt/irgsh-repo
RUN cd /opt/irgsh-web && \
  ln -s /opt/irgsh/irgsh && \
  ln -s /opt/irgsh-node/irgsh_node && \
  ln -s /opt/irgsh-repo/irgsh_repo && \
  python bootstrap.py && \
  ./bin/buildout
CMD ["/bin/bash"]
