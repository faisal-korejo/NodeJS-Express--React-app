pipeline {
    agent any


    stages {

        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/faisal-korejo/NodeJS-Express--React-app.git'
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
                archiveArtifacts artifacts: 'backend/dist/**, frontend/build/**', fingerprint: true
                stash name: 'backend', includes: 'backend/**'
                stash name: 'frontend', includes: 'frontend/build/**'
            }
        }

        stage('Deploy') {
            steps {
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
