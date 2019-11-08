FROM python:2.7
# Cloning opus fork for now, until https://github.com/subteno-it/OdooRPCLocust/pull/1 is merged upstream.
RUN git clone https://github.com/OpusVL/OdooRPCLocust.git --branch O2191-wave-1 /home/ && cd /home/ && \
        python setup.py build && \
        python setup.py install

ADD ./requirements.txt /
RUN pip install -r /requirements.txt

ADD ./tests/ /home/OdooLocust/tests/

WORKDIR /home/OdooLocust/tests/

EXPOSE 8089

CMD ["locust", "-f", "Manager.py", "Manager"]
