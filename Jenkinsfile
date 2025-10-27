pipeline {
    agent any

    environment {
        CHEF_REPO = "C:\\chef-cookbooks"
        RECIPE = "my_app_deploy"
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo "Checking out code from GitHub..."
                git branch: 'main', url: 'https://github.com/ManvithaPantham/my-app-repo.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                echo "Installing project dependencies..."
                bat '''
                cd %WORKSPACE%
                if exist package.json (
                    echo Installing NPM packages...
                    call npm install
                ) else (
                    echo No package.json found, skipping npm install
                )
                '''
            }
        }

        stage('Deploy with Chef') {
            steps {
                echo "Running Chef deployment..."
                bat """
                cd /d %CHEF_REPO%
                call chef-client --local-mode --runlist recipe[%RECIPE%]
                """
            }
        }
    }

    post {
        success {
            echo '✅ Deployment completed successfully!'
        }
        failure {
            echo '❌ Deployment failed. Check logs for details.'
        }
    }
}

