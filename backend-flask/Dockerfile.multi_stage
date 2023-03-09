## Build Stage 
FROM python:3.10-slim-buster AS builder

# Install container dependencies 
RUN apt update

# Create virtual environment to install all dependencies
RUN python3 -m venv venv
ENV PATH=/venv/bin:$PATH

# Install python 
WORKDIR /backend-flask
COPY requirements.txt .
RUN pip3 install -r requirements.txt



## Run Stage
FROM python:3.10-slim-buster
WORKDIR /backend-flask

## Create sergio user and group
RUN addgroup --system sergio && adduser --system --ingroup sergio sergio

## Set ownership of the application directory to the sergio user and group
RUN chown -R sergio:sergio /backend-flask


RUN apt-get update
RUN apt-get install -y curl

## Copy the virtual environment from the `builder` stage 
COPY --from=builder /venv /venv
ENV PATH=/venv/bin:$PATH

# Finally, copy in application 
COPY --chown=sergio:sergio . . 
USER sergio

RUN chmod +x run_script.sh


ENTRYPOINT [ "./run_script.sh" ]
