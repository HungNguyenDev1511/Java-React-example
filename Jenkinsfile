pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')
        GIT_CREDENTIALS = credentials('github-credentials')
        TERRAFORM_HOME = '/usr/local/bin'
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'github-credentials', url: 'https://github.com/yourusername/your-repo.git'
            }
        }
        
        stage('Build Backend') {
            steps {
                dir('backend') {
                    sh 'mvn clean package -DskipTests'
                }
            }
        }
        
        stage('Build Frontend') {
            steps {
                dir('frontend') {
                    sh 'yarn install'
                    sh 'yarn build'
                }
            }
        }
        
        stage('Build Docker Images') {
            steps {
                script {
                    dockerImageBackend = docker.build("yourusername/backend:${env.BUILD_ID}", 'backend')
                    dockerImageFrontend = docker.build("yourusername/frontend:${env.BUILD_ID}", 'frontend')
                }
            }
        }
        
        stage('Push Docker Images') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'DOCKER_HUB_CREDENTIALS') {
                        dockerImageBackend.push()
                        dockerImageFrontend.push()
                    }
                }
            }
        }

        stage('Deploy Infrastructure') {
            steps {
                script {
                    dir('terraform') {
                        withEnv(["PATH+TERRAFORM=${env.TERRAFORM_HOME}"]) {
                            sh 'terraform init'
                            sh 'terraform apply -auto-approve'
                        }
                    }
                }
            }
        }
        
        stage('Provision VMs') {
            steps {
                script {
                    sh 'chmod +x deploy_backend.sh deploy_frontend.sh deploy_db.sh'
                    sh './deploy_backend.sh'
                    sh './deploy_frontend.sh'
                    sh './deploy_db.sh'
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
