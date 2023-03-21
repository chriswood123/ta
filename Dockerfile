FROM python:3.12.0a6-alpine3.17 AS app

WORKDIR /app

COPY setup.py setup.py

COPY hello hello

RUN python setup.py install && rm setup.py

EXPOSE 5000

ENV FLASK_APP=hello

CMD [ "flask", "run", "--host=0.0.0.0"]

FROM app AS tests

WORKDIR /app

RUN pip install pytest

COPY tests tests

WORKDIR /app/tests

CMD [ "pytest" ]