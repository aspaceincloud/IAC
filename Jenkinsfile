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
                sh 'IAC/env/dev/terraform fmt'
                sh 'IAC/env/dev/terraform validate'
            }
        }
        stage('run terraform commands') {
            steps {
                sh 'IAC/env/dev/terraform init'
                sh 'IAC/env/dev/terraform state pull'
                sh 'IAC/env/dev/terraform plan'
            }
        }
    }

}
