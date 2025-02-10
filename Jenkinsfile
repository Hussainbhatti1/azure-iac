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
                        export ARM_CLIENT_ID="$AZURE_CLIENT_ID"
                        export ARM_CLIENT_SECRET="$AZURE_CLIENT_SECRET"
                        export ARM_TENANT_ID="$AZURE_TENANT_ID"
                        export ARM_SUBSCRIPTION_ID="$AZURE_SUBSCRIPTION_ID"

                        # Initialize and deploy infrastructure
                        terraform init
                        terraform apply -auto-approve
                    '''
                }
            }
        }
    }
}