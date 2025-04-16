pipeline {
    agent any

    environment {
        ACR_NAME = 'acrkeshav150425'
        AZURE_CREDENTIALS_ID = 'azure-service-principal'
        ACR_LOGIN_SERVER = "${ACR_NAME}.azurecr.io"
        IMAGE_NAME = 'webapidocker1'
        IMAGE_TAG = 'latest'
        RESOURCE_GROUP = 'rg-aks'
        AKS_CLUSTER = 'aksDotNetWebapi'
        TF_WORKING_DIR = '"C:\\Users\\user\\Downloads\\terraform_1.11.3_windows_386\\terraform.exe"'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/keshav99281/apiContainerK.git'
            }
        }

        stage('Build .NET App') {
            steps {
                bat 'dotnet publish ApiContainer/ApiContainer.csproj -c Release -o out'
            }
        }

        // stage('Build Docker Image') {
        //     steps{
        //             bat "docker build -t %ACR_LOGIN_SERVER%/%IMAGE_NAME%:%IMAGE_TAG% -f ApiContainer/Dockerfile ApiContainer"   
        //     }
        // }

      stage('Terraform Init') {
           steps {
               dir('terraform'){
                bat 'terraform init '
               }
          }
    }
      stage('Terraform Plan & Apply') {
           steps {
               dir('terraform'){
                 bat 'terraform plan -out=tfplan'
                 bat 'terraform apply -auto-approve'
               }
           }
     }
        
        stage('Login to ACR') {
            steps {
                bat "az acr login --name %ACR_NAME%"
            }
        }

        stage('Push Docker Image to ACR') {
            steps {
                bat "docker push %ACR_LOGIN_SERVER%/%IMAGE_NAME%:%IMAGE_TAG%"
            }
        }

        stage('Get AKS Credentials') {
            steps {
                bat "az aks get-credentials --resource-group %RESOURCE_GROUP% --name %AKS_CLUSTER% --overwrite-existing"
            }
        }

        stage('Deploy to AKS') {
            steps {
                bat "kubectl apply -f ApiContainer/deployment.yaml"
            }
        }
    }

    post {
        success {
            echo 'All stages completed successfully!'
        }
        failure {
            echo 'Build failed.'
        }
    }
}
