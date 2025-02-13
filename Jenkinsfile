pipeline {
    agent any
    environment {
        SCANNER_HOME = tool 'sonarqube-scanner'
    }
    stages {

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
                withSonarQubeEnv('SonarQube') {
                    sh '''
                    ${SCANNER_HOME}/bin/sonar-scanner \
                      -Dsonar.projectKey=my-iac-project \
                      -Dsonar.sources=. \
                      -Dsonar.host.url=http://10.0.0.4:9000 \
                      -Dsonar.login=squ_e676d58909627e2e81bdf23477d7ba1e3c5735e1
                    '''
                }
            }
        }

        stage('Quality Gate') {
            steps {
                script {
                    def qg = waitForQualityGate()
                    if (qg.status != 'OK') {
                        error "Pipeline aborted due to quality gate failure: ${qg.status}"
                    }
                }
            }
        }

    }
}

