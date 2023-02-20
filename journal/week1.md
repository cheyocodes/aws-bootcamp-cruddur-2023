# Week 1 — App Containerization

## Todo Checklist 
- [ ] [Watched Grading Homework Summaries](https://www.youtube.com/watch?v=FKAScachFgk&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=25)
- [ ] [Watched Week 1 - Live Streamed Video](https://www.youtube.com/watch?v=zJnNe5Nv4tE&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=22)
- [ ] [Remember to Commit Your Code](https://www.youtube.com/watch?v=b-idMgFFcpg&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=23)
- [ ] [Watcked Chirag's Week 1 - Spending Considerations](https://www.youtube.com/watch?v=OAMHu1NiYoI&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=24)
- [ ] [Watched Ashish's Week 1 - Container Security Considerations](https://www.youtube.com/watch?v=OjZz4D0B-cA&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=25)
- [ ] [Containerize Application (Dockerfiles, Docker Compose)](https://www.youtube.com/watch?v=zJnNe5Nv4tE&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=22)
    - [X] Containerized `backend-flask` application
- [ ] [Document the Notification Endpoint for the OpenAI Document](https://www.youtube.com/watch?v=k-_o0cCpksk&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=27)
- [ ] [Write a Flask Backend Endpoint for Notifications](https://www.youtube.com/watch?v=k-_o0cCpksk&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=27)
- [ ] [Write a React Page for Notifications](https://www.youtube.com/watch?v=k-_o0cCpksk&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=27)
- [ ] [Run DynamoDB Local Container and ensure it works](https://www.youtube.com/watch?v=CbQNMaa6zTg&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=28)
- [ ] [Run Postgres Container and ensure it works](https://www.youtube.com/watch?v=CbQNMaa6zTg&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=28)


## Required Homework 
### Containerize `backend-flask`
![Backend Flask Dockerfile](../journal/assets/week-01/backend-flask-Dockerfile.png)

### Install flask dependencies and Run run server on Gitpod
![Install dependencies and run flask server](../journal/assets/week-01/install-flask-req-and-run-flask-server-locally.png)

Install dependencies
```sh
pip3 install -r requirements.txt --quiet
```
This command is used to install Python packages specified in a file called requirements.txt using the pip3 package manager. The --quiet flag is used to suppress the output of the installation process.


```sh
python3 -m flask run --host="0.0.0.0" --port=4567
```
Here's a breakdown of the command and what each option does:
-   `python3`: This is the command to run the Python 3 interpreter.
-   `-m flask`: This option tells the Python interpreter to run the Flask module as a script.
-   `run`: This is the command to start the Flask development server.
-   `--host="0.0.0.0"`: This option tells the Flask development server to listen on all network interfaces, allowing the server to be accessible from outside the container.
-   `--port=4567`: This option specifies the port number that the Flask development server should listen on.

#### Unlock URL by clicking on the Lock icon
We must do this in Gitpod to gain access to the server from the URL provided. 
![Unlock server URL on Gitpod](../journal/assets/week-01/unlock-url-in-gitpod.png)


#### Not Found and Internal Server Errors 
We got a **Not Found (404) Error** because the root route (`/`) does not exist in the server. Therefore, the server is unable to find the requested resource. 
![Not found Error](../journal/assets/week-01/not-found-flask-server.png)

In this case we got an **Internal Server (500) Error** because we needed to set environment variables that allow the server to function properly. 
![Internal Server Error](../journal/assets/week-01/internal-server-error-flask-server.png)


To fix these issues 👆, we needed to set two environment variables used to enable Cross-Origin Resource Sharing (CORS) requests for the flask application:

```sh 
export BACKEND_URL="*"
export FRONTEND_URL="*"
```

We also needed to append `/api/activities/home` to the backend url. 
Here's the result after successfully setting the environment variables: 


![JSON result](../journal/assets/week-01/json-result-after-setting-envars.png)


### Building the flask backend image 
```sh
# run this from the root folder
docker build -t flask-backend ./flask-backend
```

- `docker build` is the command used to build a Docker image. It takes a `Dockerfile` and a build context as input, and produces a new Docker image as output.
- `-t flask-backend` is a flag that specifies the name and optionally a tag to be assigned to the resulting Docker image. In this case, the name of the image is flask-backend.
- `./flask-backend` is the path to the build context, which is the set of files and directories that will be used as input for building the Docker image. In this case, it specifies the directory where the Dockerfile for the Flask backend is located.

So, when you run the command `docker build -t flask-backend ./flask-backend`, Docker will look for the `Dockerfile` in the `./flask-backend` directory and use it to create a new Docker image with the name `flask-backend`. The resulting image will contain all the dependencies and configurations required to run the Flask backend.

It's important to know that there are other flags and options that can be used with the docker build command to customize the build process, such as `--no-cache` to disable caching during the build, `-f` to specify a different `Dockerfile` name or location, and `-q` to suppress the build output.






<!-- ![](../journal/assets/week-01/) -->














### Containerize `frontend-react-js`

### Create `docker-compose.yml` file

---
## Homework Challenges 
- [ ] Run the dockerfile CMD as an external script
- [ ] Push and tag a image to DockerHub (they have a free tier)
- [ ] Use multi-stage building for a Dockerfile build
- [ ] Implement a healthcheck in the V3 Docker compose file
- [ ] Research best practices of Dockerfiles and attempt to implement it in your Dockerfile
- [ ] Learn how to install Docker on your localmachine and get the same containers running outside of Gitpod / Codespaces
- [ ] Launch an EC2 instance that has docker installed, and pull a container to demonstrate you can run your own docker processes. 
