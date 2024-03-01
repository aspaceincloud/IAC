pipeline {
    agent any 

    stages {
        stage('Git Checkout') {
            steps {
                sh 'git clone https://github.com/aspaceincloud/IAC.git'
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
