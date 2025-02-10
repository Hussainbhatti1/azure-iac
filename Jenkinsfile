pipeline {
    agent any
    environment {
        AZURE_CREDENTIALS = credentials('azure-sp') // Reference your Azure credentials stored in Jenkins
        AZURE_SUBSCRIPTION_ID = credentials('azure-sp').subscription_id // Update with correct variable names
        AZURE_CLIENT_ID = credentials('azure-sp').client_id
        AZURE_CLIENT_SECRET = credentials('azure-sp').client_secret
        AZURE_TENANT_ID = credentials('azure-sp').tenant_id

        echo "My client id is $AZURE_CLIENT_ID"
        echo "My client secret is $AZURE_CLIENT_SECRET"
        echo "My tenant id is $AZURE_TENANT_ID"
        echo "My subscription id is $AZURE_SUBSCRIPTION_ID"
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
