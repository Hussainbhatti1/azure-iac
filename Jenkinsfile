pipeline {
    agent any
    environment {
        AZURE_CREDENTIALS = credentials('azure-sp') // Reference your Azure credentials stored in Jenkins
        AZURE_SUBSCRIPTION_ID = '${AZURE_CREDENTIALS_SUBSCRIPTION_ID}' // Use proper quoting
        AZURE_CLIENT_ID = '${AZURE_CREDENTIALS_CLIENT_ID}'
        AZURE_CLIENT_SECRET = '${AZURE_CREDENTIALS_CLIENT_SECRET}'
        AZURE_TENANT_ID = '${AZURE_CREDENTIALS_TENANT_ID}'
    }
    stages {
        stage('Terraform Init') {
            steps {
                script {
                    sh '''
                    terraform init
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    sh '''
                    terraform apply -auto-approve \
                    -var="subscription_id=${AZURE_SUBSCRIPTION_ID}" \
                    -var="client_id=${AZURE_CLIENT_ID}" \
                    -var="client_secret=${AZURE_CLIENT_SECRET}" \
                    -var="tenant_id=${AZURE_TENANT_ID}" \
                    '''
                }
            }
        }
    }
}
