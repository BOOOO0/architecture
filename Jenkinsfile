pipeline{
    agent any
    stages{
        stage("Build"){
            steps{
                script{
                    sh './server/gradlew build'
                }
            }
            post{
                success{
                    sh '/usr/local/bin/aws --endpoint-url=https://kr.object.ncloudstorage.com s3 cp ./server/build/libs/server-0.0.1-SNAPSHOT.jar s3://itwassummer0815/${JOB_NAME}${BUILD_NUMBER}.jar'
                }
            }
        }
        stage("Deploy"){
            steps{
                sh '''
ansible-playbook -i ./ansible/back_inventory.ini ./ansible/backend_playbook.yml --extra-vars "file_name='${JOB_NAME}${BUILD_NUMBER}.jar'"
                   '''
            }
        }
    }
}