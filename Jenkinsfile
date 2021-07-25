pipeline {
    agent any

    parameters {
        choice(choices: ['Minor', 'Major'], description: 'Major= increment by 1.0.0\nMinor=increment by 0.1.0', name:'releaseVersion' )
        string(defaultValue: 'dbt_user', description: 'User name target server', name: 'userName')
        string(defaultValue: 'dbt_server', description: 'Target DBT server', name: 'targetServer')
        string(defaultValue: '/usr/app/', description: 'Target directory', name: 'targetDir')
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
        stage('Check-out repository'){
            steps {
                checkout scm

                sh 'printenv'
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

                            ssh ${userName}@${targetServer}  "if [ -d '${targetDir}' ]; then rm -Rf ${targetDir}; fi; mkdir ${targetDir}" &&
                            scp -r ${WORKSPACE}/* dbt_user@airflow_dbt-dev_1:${targetDir}
                        '''
//                     }
                }
            }
        }
    }
}