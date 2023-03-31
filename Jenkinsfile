pipeline {
    agent any
    tools {
        maven 'Maven'
    }
     environment{
        IMAGE_NAME = 'Banking-finance-app-1.0.0'
    }

    stages{
        stage('Git checkout'){
            steps{
                script{
                    echo 'The github repository integrated succefully'
                }
            }
        }

        stage("Building the Banking  Application"){
            steps{
                script{
                    echo "Cleaning ...Compiling...Testing....Packaging... "
                     sh 'mvn clean package'
                }
            }
        }

        stage('publish the Banking Application test reports'){
            steps{
                script{
                     publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/jenkins_home/workspace/Banking-capstone-project/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
                }
            }
        }

         stage('Build and Push image') {
            steps {
                script {
                        withCredentials([usernamePassword(credentialsId: 'Docker-hub-repo', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        echo "building the docker image..."
                        sh "docker build -t iamabhi1997/my-apps:${IMAGE_NAME} ."
                        echo "${IMAGE_NAME} build Successfully"
                        echo 'Login to Docker hub'
                        sh "echo $PASS | docker login -u $USER --password-stdin"
                        echo "Pushing image ${IMAGE_NAME} to Docker hub "
                        sh "docker push iamabhi1997/my-apps:${IMAGE_NAME}"
                        echo "${IMAGE_NAME} push Successfully in Docker hub"
                    }
                }
            }
        }
    
        stage('provision Kubernetes cluster on Linode') {
            environment {
                TF_VAR_token = credentials('linode-api-token')
            }
            steps {
                script {
                    echo 'Provisioning Kubernetes cluster on Linode using Terraform.....'
                    dir('Terraform') {
                        sh "terraform init"
                        sh "terraform apply --auto-approve"
                        sh "bash ./server-cmd.sh"
                    }
                }
            }
        }
        stage('Deploying Banking app on cluster Ansible'){
            steps{
                script{
                    echo 'Deploying Banking application on Kubernetes cluster'
                    dir('Ansible'){
                        sh "bash ./cmds.sh"
                        sh "ansible-playbook deploy-to-k8s.yaml "
                        sh "bash ./pods.sh"
                        
                    }
                }
            }
        }

        

    }

}