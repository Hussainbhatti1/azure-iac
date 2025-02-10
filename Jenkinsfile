pipeline {
  agent any

  // Load Azure credentials from Jenkins
  environment {
    ARM_CLIENT_ID       = credentials('azure-sp').clientId
    ARM_CLIENT_SECRET   = credentials('azure-sp').clientSecret
    ARM_SUBSCRIPTION_ID = credentials('azure-sp').subscriptionId
    ARM_TENANT_ID       = credentials('azure-sp').tenantId
  }

  stages {
    // Stage 1: Checkout code from Git
    stage('Checkout') {
      steps {
        checkout scm  // Pulls code from this repo
      }
    }

    // Stage 2: Initialize Terraform
    stage('Terraform Init') {
      steps {
        sh 'terraform init'
      }
    }

    // Stage 3: Generate execution plan
    stage('Terraform Plan') {
      steps {
        sh 'terraform plan -out=tfplan'
      }
    }

    // Stage 4: Apply changes
    stage('Terraform Apply') {
      steps {
        sh 'terraform apply -auto-approve tfplan'
      }
    }
  }

  // Clean up workspace after pipeline runs
  post {
    always {
      cleanWs()
    }
  }
}