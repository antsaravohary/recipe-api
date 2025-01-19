FROM python:3.9-alpine3.13
LABEL maintainer="antsaravohary"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

#1st create virtual environment for dependencies
RUN python -m venv /py && \ 
#2nd upgrade pip and install dependencies
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
#3rd remove temporary files after installation of dependencies
    rm -rf /tmp && \
#4th add a user to run the application inside the app
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user