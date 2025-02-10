pipeline {
    agent any
    environment {
        ARM_CLIENT_ID = credentials('ARM_CLIENT_ID')
        ARM_CLIENT_SECRET = credentials('ARM_CLIENT_SECRET')
        ARM_TENANT_ID = credentials('ARM_TENANT_ID')
        ARM_SUBSCRIPTION_ID = credentials('ARM_SUBSCRIPTION_ID')
    }
    stages {
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Apply') {
            steps {
                sh '''
                terraform apply -auto-approve \
                -var="subscription_id=${ARM_SUBSCRIPTION_ID}" \
                -var="client_id=${ARM_CLIENT_ID}" \
                -var="client_secret=${ARM_CLIENT_SECRET}" \
                -var="tenant_id=${ARM_TENANT_ID}"
                '''
            }
        }
    }
}
