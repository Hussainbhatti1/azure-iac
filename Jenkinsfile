pipeline {
    agent any

    stages {
        // Stage 1: Checkout code from Git
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        // Stage 2: Terraform commands with Azure authentication
        stage('Terraform') {
            steps {
                withCredentials([azureServicePrincipal('azure-sp')]) {
                    // Terraform uses ARM_* environment variables for Azure auth
                    sh '''
                        # Set Terraform environment variables
                        export ARM_CLIENT_ID="$CLIENT_ID"
                        export ARM_CLIENT_SECRET="$CLIENT_SECRET"
                        export ARM_TENANT_ID="$TENANT_ID"
                        export ARM_SUBSCRIPTION_ID="$SUBSCRIPTION_ID"

                        # Initialize and deploy infrastructure
                        terraform init
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