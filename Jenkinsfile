pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/OrHazizaNitzanimToTech/CD-FWS.git'
        REPO_BRANCH = 'main'
        IMAGE_NAME = 'myapp'
        CONTAINER_NAME = 'nginx-app'
    }
  

    stages {
        stage('Checkout') {
            steps {
                // Clone the repository
                git url: "${REPO_URL}", branch: "${REPO_BRANCH}"
                // Optionally, list files to verify checkout
                sh 'ls -l'
            }
        }
        stage('delete imsages'){
            steps{
                script{
                    sh 'docker image prune -a -f'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Change directory to 'src' where Dockerfile and index.html are located
                    dir('src') {
                        // Build Docker image with no cache to ensure latest changes and delete all images before creation 
                        
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
                        docker rm ${CONTAINER_NAME}
                    fi
                    '''
                    
                    // Run the new container
                    sh 'docker run -d --name ${CONTAINER_NAME} -p 80:80 ${IMAGE_NAME}'
                }
            }
        }
    }
    
    post {
        failure {
            // Cleanup if something goes wrong
            script {
                sh '''
                if [ $(docker ps -q -f name=${CONTAINER_NAME}) ]; then
                    docker stop ${CONTAINER_NAME}
                    docker rm ${CONTAINER_NAME}
                fi
                '''
            }
        }
    }
}


                     






