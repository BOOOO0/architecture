pipeline{
    agent any
    stages{
        stage("Checkout Repo") {
            steps {
                cleanWs()
                checkout([$class: 'GitSCM', branches: [[name: 'deploy/client']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/BOOOO0/architecture.git']]])
            }
        }
        stage("Build"){
            steps{
                nodejs('node18'){
                    sh 'npm install'
                    sh 'npm run build'
                    sh 'tar -zcf ${JOB_NAME}${BUILD_NUMBER}.tar.gz ./build/*'
                }
            }
            post{
                success{
                    sh '/usr/local/bin/aws --endpoint-url=https://kr.object.ncloudstorage.com s3 cp ./${JOB_NAME}${BUILD_NUMBER}.tar.gz s3://itwassummer0815/${JOB_NAME}${BUILD_NUMBER}.tar.gz'
                }
            }
        }
        stage("Deploy"){
            steps{
                sh '''
ansible-playbook -i ./ansible/front_inventory.ini ./ansible/frontend_playbook.yml --extra-vars "file_name='${JOB_NAME}${BUILD_NUMBER}.tar.gz'"
                   '''
            }
        }
    }
}