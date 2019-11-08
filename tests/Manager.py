# -*- coding:utf-8 -*-
from os import environ
from OdooRPCLocust import OdooRPCLocust
from odoo_task_set import OdooTaskSet

class Manager(OdooRPCLocust):
    """
    Manager of the tasks

    Attributes:
        host (str): ip or hostname of the host in which the tests are going to be run
        database: (str): name of the database
        user (str): login of the user (odoo)
        password (str): password of that user
        port (int): listening port (odoo)
    """
    min_wait = 100
    max_wait = 1000
    weight = 3
    host = environ["ODOO_HOST"]
    database = environ["ODOO_DATABASE"]
    user = environ["ODOO_LOGIN"]
    password = environ["ODOO_PASSWORD"]
    port = int( environ["ODOO_PORT"] )

    task_set = OdooTaskSet
