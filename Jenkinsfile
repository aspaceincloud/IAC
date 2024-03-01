pipeline {
    agent any 

    stages {
        stage('Git Checkout') {
            steps {
                git credentialsId: '5627ae37-58d5-4499-a716-2eeb98704359', url: 'https://github.com/aspaceincloud/IAC.git'
            }
        }

        stage('Check for the terraform syntaxs') {
            steps{
                sh 'cd env/dev'
                sh 'env/devterraform fmt'
                sh 'terraform validate'
                 sh 'terraform init'
                sh 'terraform plan -var-file=dev.tfvars'
            }
        }
        stage('run terraform commands') {
            steps {
                sh 'echo Hello'
               
            }
        }
    }

}
