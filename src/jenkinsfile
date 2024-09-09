pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout the latest code from the GitHub repository
                git url: 'https://github.com/Bar-Tubul/Ansible-CI-CD-FWS.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image with a tag
                    sh 'docker build -t myapp .'
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                script {
                    // Start or restart the Docker container
                    sh 'docker-compose up -d'
                }
            }
        }
    }

    post {
        always {
            // Clean up any resources, if necessary
            sh 'docker-compose down'
        }
    }
}
