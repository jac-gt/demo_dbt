FROM python:3.8.1-slim-buster

RUN useradd -m dbt_user -g root -G sudo -u 1000

# change password
RUN echo "dbt_user:dbt_user" | chpasswd

RUN echo "root:docker" | chpasswd

# USER dbt_user

RUN apt-get update && apt-get dist-upgrade -y  && apt-get install -y --no-install-recommends openssh-server openssh-client git software-properties-common make build-essential ca-certificates libpq-dev && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# RUN  echo "Port 2200" >> /etc/ssh/sshd_config

RUN service ssh start

EXPOSE 22

COPY docker/requirements.txt ./requirements.txt

RUN pip install --upgrade pip setuptools
RUN pip install --requirement ./requirements.txt
RUN pip install dbt
# RUN pip install ./dist/dbt_bigquery-0.17.0rc4-py3-none-any.whl ./dist/dbt_snowflake-0.17.0rc4-py3-none-any.whl ./dist/dbt_core-0.17.0rc4-py3-none-any.whl ./dist/dbt_postgres-0.17.0rc4-py3-none-any.whl ./dist/dbt-0.17.0rc4-py3-none-any.whl ./dist/dbt_redshift-0.17.0rc4-py3-none-any.whl

ENV PYTHONIOENCODING=utf-8
ENV LANG C.UTF-8

WORKDIR /usr/app
VOLUME /usr/app

CMD ["/usr/sbin/sshd","-D"]