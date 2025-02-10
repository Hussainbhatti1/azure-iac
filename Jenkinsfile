pipeline {
    agent any

    stages {
        // Checkout code from Git
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        // Authenticate to Azure
        stage('Azure Login') {
            steps {
                withCredentials([azureServicePrincipal('azure-sp')]) {
                    // Azure credentials are auto-injected as env vars:
                    // AZURE_CLIENT_ID, AZURE_CLIENT_SECRET, AZURE_TENANT_ID, AZURE_SUBSCRIPTION_ID
                    sh '''
                        echo "Logging into Azure..."
                        az login --service-principal \
                          -u $AZURE_CLIENT_ID \
                          -p $AZURE_CLIENT_SECRET \
                          -t $AZURE_TENANT_ID
                    '''
                }
            }
        }

        // Terraform stages
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    }
}