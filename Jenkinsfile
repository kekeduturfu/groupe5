pipeline {
    agent any

    environment {
        IMAGE_NAME = 'kekeduturfu/groupe5'
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
    }

    stages {
        stage('Checkout') {
            steps {
                // Récupère le code depuis le dépôt GitHub lié au job Jenkins
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Construit une image Docker avec un tag unique basé sur le numéro du build Jenkins
                    sudo docker.build -t "${IMAGE_NAME}:${env.BUILD_NUMBER}" .
                  
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    // Se connecte à DockerHub et pousse l'image
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS_ID}") {
                        docker.image("${IMAGE_NAME}:${env.BUILD_NUMBER}").push()
                        // (Optionnel) : aussi pousser le tag "latest"
                        docker.image("${IMAGE_NAME}:${env.BUILD_NUMBER}").tag("latest")
                        docker.image("${IMAGE_NAME}:latest").push()
                    }
                }
            }
        }
    }

    post {
        success {
            echo "✅ Image Docker créée et poussée avec succès sur DockerHub : ${IMAGE_NAME}:${env.BUILD_NUMBER}"
        }
        failure {
            echo "❌ Échec du processus de build ou push Docker."
        }
    }
}
