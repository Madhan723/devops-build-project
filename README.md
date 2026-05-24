🚀 DevOps CI/CD Pipeline Project

A complete CI/CD pipeline implementation using Docker, Jenkins, GitHub Webhooks, DockerHub, and AWS EC2 for automated application deployment and monitoring.

📌 Project Overview

This project automates the complete software delivery lifecycle:

Source code integration from GitHub
Docker image creation
DockerHub image push
Automated deployment on AWS EC2
Continuous monitoring using Uptime Kuma
🛠️ Tech Stack
Tool	Purpose
AWS EC2 Ubuntu	Cloud Server
Docker	Containerization
Jenkins	CI/CD Automation
GitHub	Source Code Management
DockerHub	Docker Registry
React	Frontend Application
Uptime Kuma	Monitoring
📂 Project Structure
devops-build-project/
│
├── build/
├── Dockerfile
├── docker-compose.yml
├── Jenkinsfile
├── .dockerignore
├── .gitignore
└── README.md
⚙️ CI/CD Workflow
Developer Push
      ↓
GitHub Repository
      ↓
GitHub Webhook
      ↓
Jenkins Pipeline
      ↓
Docker Build
      ↓
DockerHub Push
      ↓
EC2 Deployment
      ↓
Monitoring with Uptime Kuma
🐳 Docker Setup
Dockerfile
FROM nginx:alpine

COPY build/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
🔄 Jenkins Pipeline
Development Pipeline
Branch: dev
Docker Image: madhan723/dev
Production Pipeline
Branch: main
Docker Image: madhan723/prod
📜 Jenkinsfile
pipeline {
    agent any

    environment {
        IMAGE_NAME = "madhan723/dev"
        TAG = "${BUILD_NUMBER}"
    }

    stages {

        stage('Clone') {
            steps {
                git branch: 'dev',
                url: 'https://github.com/Madhan723/devops-build-project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$TAG .'
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {

                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Push Image') {
            steps {
                sh 'docker push $IMAGE_NAME:$TAG'
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                docker rm -f react-container || true

                docker run -d \
                --name react-container \
                -p 80:80 \
                $IMAGE_NAME:$TAG
                '''
            }
        }
    }
}
☁️ AWS Security Group Configuration
Type	Port
SSH	22
HTTP	80
Jenkins	8080
Uptime Kuma	3001
🔗 GitHub Webhook

Webhook URL:

http://<EC2_PUBLIC_IP>:8080/github-webhook/

Trigger:

Push Events
📦 DockerHub Repositories
Repository	Purpose
madhan723/dev	Development Images
madhan723/prod	Production Images
🧩 Jenkins Setup
Run Jenkins Container
docker run -d \
--name jenkins \
-p 8080:8080 \
-p 50000:50000 \
-v jenkins_home:/var/jenkins_home \
-v /var/run/docker.sock:/var/run/docker.sock \
-u root \
jenkins/jenkins:lts
📈 Monitoring with Uptime Kuma
Run Uptime Kuma
docker run -d \
--restart=always \
-p 3001:3001 \
--name uptime-kuma \
-v uptime-kuma:/app/data \
louislam/uptime-kuma
🌐 Access URLs
React Application
http://<EC2_PUBLIC_IP>
Jenkins Dashboard
http://<EC2_PUBLIC_IP>:8080
Uptime Kuma Dashboard
http://<EC2_PUBLIC_IP>:3001
🚀 Features
Automated CI/CD pipeline
Dockerized deployment
Jenkins automation
GitHub webhook integration
DockerHub image management
Monitoring and uptime alerts
Separate development and production environments
🔮 Future Enhancements
Kubernetes deployment
SSL with Nginx
Terraform automation
Prometheus + Grafana monitoring
Blue-Green deployment strategy
👨‍💻 Author
Madhan G

GitHub Profile:
Madhan723 GitHub

Project Repository:
DevOps Build Project Repository
