pipeline {
    agent any

    environment {
        CHEF_REPO = "C:/chef-cookbooks"
        RECIPE = "my_app_deploy"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git credentialsId: 'my-git-cred', url: 'https://github.com/ManvithaPantham/my-app-repo.git'
            }
        }

        stage('Build') {
            steps {
                echo "Installing dependencies..."
                bat "cd %WORKSPACE% && npm install"
            }
        }

        stage('Deploy with Chef') {
            steps {
                bat "chef-client --local-mode --runlist 'recipe[${RECIPE}]'"
            }
        }
    }

    post {
        success {
            echo 'Deployment completed successfully!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
}