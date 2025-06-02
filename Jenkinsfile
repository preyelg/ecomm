pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'preyelg/ecommerce-app'
        IMAGE_TAG = "${env.BUILD_NUMBER}"
    }

    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'clean-deployment', url: 'https://github.com/preyelg/ecomm.git'
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
                withCredentials([
                    usernamePassword(
                        credentialsId: 'docker-hub',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    bat """
                        echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin
                        docker push %DOCKER_IMAGE%:%IMAGE_TAG%
                    """
                }
            }
        }

        stage('Deploy to EKS') {
            steps {
                withCredentials([
                    string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    bat """
                        aws eks update-kubeconfig --region us-east-2 --name ecommerce-eks
                        kubectl set image deployment/ecommerce-app ecommerce-app=%DOCKER_IMAGE%:%IMAGE_TAG%
                    """
                }
            }
        }

        stage('Test kubectl') {
            steps {
                bat 'kubectl get nodes'
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
