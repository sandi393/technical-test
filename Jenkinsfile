pipeline {
    agent any

    stages {
        stage('SCM') {
            steps {
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
                echo 'Ini adalah stage Build'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Ini adalah stage Deploy'
            }
        }
    }
}

