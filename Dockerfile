FROM python:3.8-buster
RUN apt update
RUN apt upgrade -y
RUN apt install -y nano bash-completion less \
    python3-dev libxml2-dev libxslt1-dev libldap2-dev libsasl2-dev \
    libtiff5-dev libjpeg62-turbo-dev libopenjp2-7-dev zlib1g-dev libfreetype6-dev \
    liblcms2-dev libwebp-dev libharfbuzz-dev libfribidi-dev libxcb1-dev libpq-dev \
    postgresql postgresql-client

WORKDIR /odoo
COPY ./odoo /odoo/CommunityPath

RUN /usr/local/bin/python -m pip install --upgrade pip
RUN pip install setuptools==57.0.0 wheel==0.36.2
RUN pip install --no-cache-dir -r /odoo/CommunityPath/requirements.txt
# CMD ["python", "/odoo/CommunityPath/odoo-bin --addons-path=addons -d postgres"]




# For testing
# COPY /test-script .
# CMD ["python", "/odoo/main.py"]
