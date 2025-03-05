pipeline {
    agent any
    environment {
        ARM_CLIENT_ID     = '69284371-215c-4646-83c8-d8e3c62796a9'
        ARM_CLIENT_SECRET = 'Gzs8Q~uw7xu_YINwBqiMFBRutGul_eaq0sXtPant'
        ARM_TENANT_ID     = 'ba61a0f0-dce9-4958-bf67-58e0ff045ad2'
        ARM_SUBSCRIPTION_ID = '8258e319-97da-4600-a76c-49edbf93df29'
    }
    stages {
        stage('Checkout') {
            steps {
               git branch: 'main', credentialsId:'4d332a54-cd64-43a6-aad1-a97f4447f947', url: 'https://github.com/KolluruSrinivas/Jenkins-Tf.git'
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }
    post {
        success {
            echo 'Terraform Applied Successfully!'
        }
        failure {
            echo 'Terraform Apply Failed!'
        }
    }
}
