pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "preyelg/ecommerce-app"
        IMAGE_TAG = "${env.BUILD_NUMBER}"
    }

    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'deployment-2', url: 'https://github.com/preyelg/ecomm.git'
            }
        }

        stage('Build with Maven') {
            steps {
                bat 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t %DOCKER_IMAGE%:%IMAGE_TAG% ."
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    bat '''
                        echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin
                        docker push %DOCKER_IMAGE%:%IMAGE_TAG%
                    '''
                }
            }
        }

        stage('Deploy to EKS') {
            steps {
                bat "kubectl set image deployment/ecommerce-app ecommerce-app=%DOCKER_IMAGE%:%IMAGE_TAG%"
            }
        }
    }

    post {
        success {
            echo "✅ Deployed successfully to EKS!"
        }
        failure {
            echo "❌ Deployment failed."
        }
    }
}
