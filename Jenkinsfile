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
        KUBECONFIG = "/Users/sandilesmana/.kube/config" //locate in jenkins EC2 serevr
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
            steps{
                script {
                  dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
                }
            }
        }
        // Uploading Docker images into AWS ECR
        stage('Pushing to ECR') {
             steps{  
                 script {
                    sh """docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:$IMAGE_TAG"""
                    sh """docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"""
                 }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    // Set KUBECONFIG environment variable
                    withEnv(["KUBECONFIG=${KUBECONFIG}"]) {
                        // Get the latest image tag from the GIT_COMMIT environment variable
                        def imageTag = env.GIT_COMMIT
                        
                        // Replace the placeholder ${IMAGE_TAG} in deployment.yaml with the actual image tag
                        sh """sed -i '' 's|\${IMAGE_TAG}|${imageTag}|' deployment.yaml"""
                        
                        // Apply deployment.yaml to the EKS cluster
                        sh """kubectl apply -f deployment.yaml"""
                        sh """kubectl apply -f service.yaml"""
                    }
                }
            }
        }
    }
}

