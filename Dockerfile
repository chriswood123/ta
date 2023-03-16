FROM python:3.12.0a6-alpine3.17

WORKDIR /app

COPY setup.py setup.py

COPY hello hello

RUN python setup.py install && rm setup.py

EXPOSE 5000

ENV FLASK_APP=hello

CMD [ "flask", "run", "--host=0.0.0.0"]