FROM python:3.8-buster

# Install base packages
RUN apt update
RUN apt upgrade -y
RUN apt install -y nano bash-completion less \
    python3-dev libxml2-dev libxslt1-dev libldap2-dev libsasl2-dev \
    libtiff5-dev libjpeg62-turbo-dev libopenjp2-7-dev zlib1g-dev libfreetype6-dev \
    liblcms2-dev libwebp-dev libharfbuzz-dev libfribidi-dev libxcb1-dev libpq-dev \
    postgresql postgresql-client

# Create a working directory and copy the odoo source code
# into the folder
WORKDIR /odoo
COPY ./odoo /odoo/CommunityPath

# Install dependancies for Odoo to function
RUN /usr/local/bin/python -m pip install --upgrade pip
RUN pip install setuptools==57.0.0 wheel==0.36.2
RUN pip install --no-cache-dir -r /odoo/CommunityPath/requirements.txt

# Create a non-root user odoo with password odoo
# and give the odoo ownership of the odoo working
# directory
RUN useradd --create-home --password $(perl -e 'print crypt($ARGV[0], "password")' 'odoo') odoo
RUN chown -R odoo:odoo /odoo

USER odoo