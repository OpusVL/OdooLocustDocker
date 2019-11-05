# What's this
This is a repo based on https://github.com/nseinlet/OdooLocust


# How to use it
Extend `docker-compose.override.yml` or create a `docker-compose.locust.yml` file (and ref it during `docker-compose` commands with `-f docker-compose.locust.yml`) with the following:

```yaml
version: '3'
services:
  odoolocust:
    image: quay.io/opusvl/odoo-locust:latest
    depends_on:
      - odoo # May need changing if your odoo service is defined as something else in docker-compose.yml
    environment:
      ODOO_LOGIN: changeme # This is the res.users record login locust will auth with when running the tests
      ODOO_PASSWORD: changeme # This is the res.users record password locust will auth with when running the tests
      ODOO_HOST: odoo # May need changing if your odoo service is defined as something else in docker-compose.yml
      ODOO_DATABASE: changeme # This is the database name you want to connect to
      ODOO_PORT: 8069 # This is the port your odoo service is exposed to
    ports:
      - 8089:8089 # This is the port to expose the locust web interface to
    volumes:
      - "./odoo_task_set.py:/home/OdooLocust/tests/odoo_task_set.py" # This is the test file that will be loaded. It _MUST_ be named `odoo_task_set.py`

```

Then start the container. The Locust web interface will be on whatever port you mapped to `8089`.

Visit the web interface and get running


# What's changed from https://github.com/Ozrlz/OdooLocustDocker
I've moved the main test script which is what will change from project to project into a seperate folder which is what we will mount.

# Typical project structure
So a typical project with a locust test will look something like this:
```
├── docker-compose-locust
├── docker-compose.locust.yml
├── docker-compose.override.yml
├── docker-compose.yml
├── odoo_task_set.py
```
`docker-compose-locust` is just a bash script that uses `-f` to pull in all relvant compose files like so:
```bash
#/bin/bash
docker-compose -f docker-compose.yml -f docker-compose.override.yml -f docker-compose.locust.yml $@
```
So when you want to run with locust, you just run `./docker-compose-locust up -d`
