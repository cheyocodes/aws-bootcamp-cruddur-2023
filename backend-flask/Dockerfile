# Multi-stage builds
# Stage 1: Build app
FROM python:3.10-slim-buster as builder 

WORKDIR /backend-flask

COPY requirements.txt requirements.txt

RUN pip3 install -r requirements.txt

COPY . .


# Stage 2: Run app
FROM python:3.10-slim-buster

WORKDIR /backend-flask

COPY --from=builder . .

RUN chmod +x run_script.sh

ENV FLASK_ENV=development

EXPOSE ${PORT}

CMD ["sh", "run_script.sh"]


