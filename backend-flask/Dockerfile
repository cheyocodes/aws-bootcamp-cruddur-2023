
FROM python:3.10-slim-buster

WORKDIR /backend-flask

COPY requirements.txt requirements.txt

RUN pip3 install -r requirements.txt

COPY . .

RUN chmod +x run_script.sh

ENV FLASK_ENV=development

EXPOSE ${PORT}

CMD ["./run_script.sh"]


# CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port=4567"]


