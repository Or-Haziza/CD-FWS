pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout the source code from the repository
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh 'docker build -t myapp .'
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    // Use Docker Compose to start the container
                    sh 'docker-compose up -d'
                }
            }
        }
    }
    
    post {
        always {
            // Clean up Docker containers and images if needed
            sh 'docker-compose down'
        }
    }
}
