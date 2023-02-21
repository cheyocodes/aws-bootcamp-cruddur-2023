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

![docker build](../journal/assets/week-01/docker-build-flask-backend.png)


Running `docker build` results in a new image being created. We can list all the images currently stored in our computer using the following command: 
```sh
docker images
```

![docker images](../journal/assets/week-01/docker-images-cmd.png)

We can run the `flask-backend` image using the `docker run` command.

**Short form**:
```sh
docker container run --rm -p 4567:4567 -d backend-flask
```

**Extended form**:
```sh
docker container run --rm \
  --publish 4567:4567 \
  --detach \
  backend-flask
```

-   `docker container run`: This is the command to run a Docker container.
-   `--rm`: This option removes the container automatically when it stops running, which helps keep the Docker environment clean.
-   `--publish 4567:4567`: This option maps the host port 4567 to the container port 4567. This means that any traffic sent to port 4567 on the host machine will be forwarded to port 4567 in the container. This is useful for exposing network services running inside the container to the host machine or to the outside world.
-   `--detach`: This option runs the container in the background (detached mode), which means the container runs in the background and frees up the terminal for further use.
-   `backend-flask`: This is the name of the image to be used for creating the container.

Overall, this command creates a new Docker container based on the `backend-flask` image, exposes port 4567 to the host machine, and runs the container in the background. When the container stops running, it is automatically removed. This command is useful for running a Flask backend application in a Docker container.

Here's the output of running the command: 

![](../journal/assets/week-01/docker-run.png)


#### Listing containers
```sh
docker container ps
```

The `docker container ps` command is used to list the currently running Docker containers on your system. The `ps` stands for **"process status"**, and it provides a list of all the active containers along with their relevant details such as the container ID, image used to create the container, container status, name of the container, and the ports exposed by the container.

By default, docker container ps lists only the running containers. However, you can use various options with this command to customize the output. For example, you can use the `-a` or `--all` option to list all the containers, including the ones that have exited. You can also use the `--filter` option to filter the list of containers based on specific criteria such as container name, ID, or status.

In summary, the docker container ps command is useful for monitoring the status of Docker containers and for troubleshooting issues related to containerization.

Here's the output of running the command: 
![docker ps output](../journal/assets/week-01/docker-ps.png)


#### Setting up environment variables 
```
docker container run --rm \
  --publish 4567:4567 \
  --detach \
  backend-flask
```

#### Troubleshooting
To check if the environment variables are set, we can view the logs generated by the container: 

```sh 
docker container logs <CONTAINER_ID>
```

Alternatively, we can view the logs using the VSCode user interface: 

![View Logs with VSCode](../journal/assets/week-01/vscode-docker-logs.png)


A more strightforward way to seeing if environment variables are set is by connecting into the container and looking manually for the environment variables. We can do this using the following command: 

```sh
docker container exec -it <CONTAINER_ID> bash
```
This command runs a new shell process inside an already running Docker container specified by its ID. It allows you to interact with the container's shell environment interactively.

Here is a breakdown of each part of the command:

- `docker exec` - This is the command to run a new command inside a running container.
- `-it` - This option is used to allocate an interactive terminal for the container process. This allows you to interact with the container's shell and run commands as if you were inside the container.
- `<CONTAINER_ID>` - This is the ID of the container you want to access. You can obtain the container ID by running the docker container ls or docker container ps command.

The bash command at the end of the line is the command that will be executed inside the container. In this case, it launches a new Bash shell process, which allows you to interact with the container's shell environment. You can replace bash with any other command you want to execute in the container.

Overall, this command is useful for accessing and interacting with a running container's shell environment. You can use it for tasks such as debugging, troubleshooting, or running custom commands inside the container.

You can also attach a shell to the running container by using the VSCode interface: 
![Attach Shell with VSCode](../journal/assets/week-01/vscode-attach-shell.png)


#### Setting Environment Variables with Docker Command
We can get the environment variable values set in our environment through the CLI: 
```sh
export FRONTEND_URL="*"
export BACKEND_URL="*"
```

```sh 
docker container run --rm --p 4567:4567 -it -e FRONTEND_URL -e BACKEND_URL= backend-flask
```

We can also access the values directly from our CLI without having to export them in our current shell session: 
```sh
docker container run --rm --p 4567:4567 -it -e FRONTEND_URL='*' -e BACKEND_URL='*' backend-flask
```

> **ATTENTION**: We use single quotes `''` instead of `""` because the shell might interpret the asterisk with double quotes (`"*"`) as a directory list of all the files. 





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
