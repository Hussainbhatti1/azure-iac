pipeline {
    agent any
    environment {
        // Use 'withCredentials' block to securely bind credentials
        AZURE_CREDENTIALS = credentials('azure-sp') // Reference the credentials by ID here
    }
    stages {
        stage('Terraform Init') {
            steps {
                script {
                    // You will access the specific credential values inside the script
                    def azureCreds = env.AZURE_CREDENTIALS
                    def clientId = azureCreds.clientId
                    def clientSecret = azureCreds.clientSecret
                    def tenantId = azureCreds.tenantId
                    def subscriptionId = azureCreds.subscriptionId

                    // Set the environment variables for Terraform execution
                    withEnv([
                        "ARM_CLIENT_ID=${clientId}",
                        "ARM_CLIENT_SECRET=${clientSecret}",
                        "ARM_TENANT_ID=${tenantId}",
                        "ARM_SUBSCRIPTION_ID=${subscriptionId}"
                    ]) {
                        sh 'terraform init'
                    }
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                script {
                    // Terraform apply with the environment variables
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
}
