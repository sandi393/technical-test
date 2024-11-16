pipeline {
    agent {
        label 'dev' 
    }

    stages {
        stage('SCM') {
            steps {
                echo 'Checkout from Repository Git'
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'git@github.com:sandi393/technical-test.git']])
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
                sh 'docker run -d -p 8000:8000 --name node-todo-app node-todo-app'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Ini adalah stage Deploy'
            }
        }
    }
}

