FROM python:2.7

RUN git clone https://github.com/subteno-it/OdooRPCLocust.git /home/ && cd /home/ && \
        python setup.py build && \
        python setup.py install

RUN pip install odoorpc

ADD ./tests/ /home/OdooLocust/tests/

WORKDIR /home/OdooLocust/tests/

EXPOSE 8089

CMD ["locust", "-f", "Manager.py", "Manager"]
