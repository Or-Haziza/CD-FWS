pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/Bar-Tubul/Ansible-CI-CD-FWS.git'
        REPO_BRANCH = 'main'
        IMAGE_NAME = 'myapp'
        CONTAINER_NAME = 'nginx-app'
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone the repository
                git url: "${REPO_URL}", branch: "${REPO_BRANCH}"
                // List files to verify checkout
                sh 'ls -l'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image with no cache to ensure latest changes
                    dir('src') {
                        sh 'docker build --no-cache -t ${IMAGE_NAME} .'
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Stop and remove the old container if it exists
                    sh '''
                    if [ $(docker ps -q -f name=${CONTAINER_NAME}) ]; then
                        docker stop ${CONTAINER_NAME}
                     






