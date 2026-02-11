pipeline {
    agent any

    environment {
        SERVER = "ubuntu@16.171.38.133"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'YOUR_GIT_REPO_URL'
            }
        }

        stage('Build Backend') {
            steps {
                dir('backend') {
                    sh 'npm install'
                    sh 'npm test'
                }
            }
        }

        stage('Build Frontend') {
            steps {
                dir('frontend') {
                    sh 'npm install'
                    sh 'npm run build'
                }
            }
        }

        stage('Archive Artifacts') {
            steps {
                stash name: 'backend', includes: 'backend/**'
                stash name: 'frontend', includes: 'frontend/build/**'
            }
        }

        stage('Deploy') {
            steps {
                sshagent(['deploy-key']) {
                    sh './deploy.sh'
                }
            }
        }
    }

    post {
        success {
            echo "Deployment Successful"
        }
        failure {
            echo "Deployment Failed"
        }
    }
}
