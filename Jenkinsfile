pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/Bar-Tubul/Ansible-CI-CD-FWS.git'
        REPO_BRANCH = 'main'
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone the repository
                git url: "${REPO_URL}", branch: "${REPO_BRANCH}"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Ensure the Dockerfile and docker-compose.yml are in the 'src' directory
                    dir('src') {
                        // Build Docker image
                        sh 'docker build -t myapp .'
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Ensure docker-compose.yml is in the 'src' directory
                    dir('src') {
                        // Start Docker container
                        sh 'docker-compose up -d'
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                // Ensure docker-compose.yml is in the 'src' directory
                dir('src') {
                    // Stop and remove Docker container
                    sh 'docker-compose down'
                }
            }
        }
    }
}

