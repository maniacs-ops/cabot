FROM python:2.7

ENV PYTHONUNBUFFERED 1

RUN mkdir /code

WORKDIR /code

RUN apt-get update && apt-get install -y \
        python-dev \
        libsasl2-dev \
        libldap2-dev \
        libpq-dev \
        npm

RUN npm install -g \
        --registry http://registry.npmjs.org/ \
        coffee-script \
        less@1.3

RUN ln -s `which nodejs` /usr/bin/node

RUN pip install --upgrade pip pipenv ipdb

COPY Pipfile* ./
RUN pipenv lock
RUN pipenv install --system
RUN pip install django_coverage_plugin==1.3.1

ADD . /code/

ENTRYPOINT ["./docker-entrypoint.sh"]
