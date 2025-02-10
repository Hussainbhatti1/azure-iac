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
                    // Extract clientId and clientSecret from the credentials
                    def clientId = env.AZURE_CREDENTIALS_USR   // Username field (Client ID)
                    def clientSecret = env.AZURE_CREDENTIALS_PSW // Password field (Client Secret)

                    // For Tenant ID and Subscription ID, you can either set them in the environment 
                    // or retrieve them from another source.
                    def tenantId = '<your-tenant-id>' // Use appropriate value or environment variable
                    def subscriptionId = '<your-subscription-id>' // Use appropriate value or environment variable

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
