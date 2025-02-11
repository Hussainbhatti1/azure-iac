pipeline {
    agent any

    stages {
        // Stage 1: Checkout code from Git
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Deploy') {
            steps {
                // Access Azure Service Principal credentials
                withCredentials([azureServicePrincipal('azure-sp')]) {
                    sh '''
                        # Terraform uses ARM_* environment variables
                        export ARM_CLIENT_ID="$AZURE_CLIENT_ID"
                        export ARM_CLIENT_SECRET="$AZURE_CLIENT_SECRET"
                        export ARM_TENANT_ID="$AZURE_TENANT_ID"
                        export ARM_SUBSCRIPTION_ID="$AZURE_SUBSCRIPTION_ID"

                        # Run Terraform commands
                        terraform init
                        terraform apply -auto-approve
                    '''
                }
            }
        }

        // Stage 3: SonarQube Analysis
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {  // Uses the SonarQube server configured in Jenkins
                    sh '''
                        # Run SonarQube scanner
                        sonar-scanner \
                          -Dsonar.projectKey=my-azure-project \
                          -Dsonar.sources=src \
                          -Dsonar.host.url=http://<VM-Private-IP>:9000 \
                          -Dsonar.login=${env.SONAR_AUTH_TOKEN}
                    '''
                }
            }
        }
    }

    // Post-build actions (e.g., notifications)
    post {
        always {
            echo 'Pipeline completed!'
        }
        success {
            slackSend channel: '#devops', message: 'Pipeline succeeded! ✅'
        }
        failure {
            slackSend channel: '#devops', message: 'Pipeline failed! ❌'
        }
    }
}

