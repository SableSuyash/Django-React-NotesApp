@Library("Shared") _

pipeline {
    agent {label "agent01"}

    stages {
        stage("Hello"){
            steps{
                hello()
            }
        }
        stage('Code') {
            steps {
                echo 'Clonning the Code...'
                clone("https://github.com/SableSuyash/Django-React-NotesApp.git","main")
                echo "Code Cloned Successfully!"
            }
        }
        stage('Build') {
            steps {
                echo 'building the Code...'
                docker_build("notes-app:latest")
                echo "Code Build Successfully!"
            }
        }
        stage('Push') {
            steps {
                echo 'pushing the docker image...'
                docker_push()
                echo "Pushed Docker Image Successfully!"
            }
        }
        stage('Deploy') {
            steps {
                echo 'deploying the Code...'
                docker_deploy()
                echo "Code Deployed Successfully!"
            }
        }
    }
}
