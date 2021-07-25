pipeline {
    agent any

    parameters {
        choice(choices: ['Minor', 'Major'], description: 'Major= increment by 1.0.0\nMinor=increment by 0.1.0', name:'releaseVersion' )
        string(defaultValue: 'dbt_user', description: 'User name target server', name: 'userName')
        string(defaultValue: 'dbt_server', description: 'Target DBT server', name: 'targetServer')
    }

    stages {
        stage('Cleanup Workspace') {
            steps {
                cleanWs()
                sh """
                echo "Cleaned Up Workspace For Project"
                """
            }
        }
        stage("build"){
            steps {
                echo "building the pipeline"
            }
        }
        stage("test") {
            steps {
                echo "testing the pipeline"
            }
        }
        stage("deploy") {
            steps {
                echo "deploying the pipeline"
                script {
//                     withCredentials([sshUserPrivateKey(credentialsId: "dbt_connection", usernameVariable: 'USERNAME')]) {
                        sh '''
                            if ! grep -q "^airflow_dbt-dev_1" ~/.ssh/known_hosts; then
                              ssh-keyscan -t rsa github.com >> /var/lib/jenkins/.ssh/known_hosts
                            fi

                            ssh ${userName}@${targetServer}

                            ls
                        '''
//                     }
                }
            }
        }
    }
}