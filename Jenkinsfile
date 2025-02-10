pipeline {
    agent any
    environment {
    AZURE_CREDENTIALS = credentials('azure-sp') // Reference your Azure credentials stored in Jenkins
    RESOURCE_GROUP_NAME = 'your-resource-group-name'
    LOCATION = 'East US'  // Or your specific Azure region
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
            -var="resource_group_name=${RESOURCE_GROUP_NAME}" \
            -var="location=${LOCATION}"
            '''
        }
        }
    }
  }
}
