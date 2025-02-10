pipeline {
  agent any
  environment {
    ARM_CLIENT_ID        = credentials('azure-sp').clientId
    ARM_CLIENT_SECRET    = credentials('azure-sp').clientSecret
    ARM_SUBSCRIPTION_ID  = credentials('azure-sp').subscriptionId
    ARM_TENANT_ID        = credentials('azure-sp').tenantId
  }
  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/your-username/azure-iac.git'
      }
    }
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