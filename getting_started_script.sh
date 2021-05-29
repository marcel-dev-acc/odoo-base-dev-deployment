#!/bin/sh
git clone https://github.com/odoo/odoo.git
docker-compose build
docker-compose up -d