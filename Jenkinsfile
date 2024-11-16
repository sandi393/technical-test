pipeline {
    agent {
        label 'dev' 
    }
    environment {
        AWS_ACCOUNT_ID="390403878874"
        AWS_DEFAULT_REGION="ap-southeast-1"
        IMAGE_REPO_NAME="belajar/sandi-aws"
        IMAGE_TAG="v1"
        REPOSITORY_URI = "390403878874.dkr.ecr.ap-southeast-1.amazonaws.com/belajar/sandi-aws"
    }

    stages {
        stage('SCM') {
            steps {
                echo 'Checkout from Repository Git'
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'git@github.com:sandi393/technical-test.git']])
            }
        }
        stage('Logging into AWS ECR') {
            steps {
                script {
                sh """aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"""
                }
                 
            }
        }
        stage('UnitTest') {
            steps {
                echo 'Ini adalah stage unit test'
            }
        }
        stage('Build') {
            steps {
                sh 'docker build . -t node-todo-app'
            }
        }
        stage('Run') {
            steps {
                echo 'Ini stage Run'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Ini adalah stage Deploy'
            }
        }
    }
}

