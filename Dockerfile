FROM oiax/rails6-deps:latest

ARG UID=1000
ARG GID=1000

RUN mkdir /var/mail
RUN groupadd -g $GID devel
RUN useradd -u $UID -g devel -m devel
RUN echo "devel ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

WORKDIR /apps
COPY Gemfile /apps/Gemfile
COPY Gemfile.lock /apps/Gemfile.lock
RUN bundle install

RUN apk add --no-cache openssl shared-mime-info

USER devel

RUN openssl rand -hex 64 > /home/devel/.secret_key_base
RUN echo $'export SECRET_KEY_BASE=$(cat /home/devel/.secret_key_base)' \
  >> /home/devel/.bashrc

