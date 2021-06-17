pipeline {
environment {
registry = "rakshithapapu7/portfolio-site"
registryCredential = 'rakshithapapu7'
dockerImage = ''
}
agent any
stages {
stage("Fix the permission issue") {
steps {
sh "sudo chown root:jenkins /run/docker.sock"
}
}
stage('download source code') {
steps {
git branch: 'main', url: 'https://github.com/rakshitha-gowda/rakshitha-gowda.github.io.git'
}
}
stage('CheckAndStop'){
steps
{
  sh returnStatus: true, script: 'sudo kill -9 $(sudo lsof -t -i:8000)'
  sh 'echo kill done'
}
}
stage('Building our image') {
steps{
script {
dockerImage = docker.build registry + ":$BUILD_NUMBER"
}
}
}
stage('push image to dockerhub') {
steps{
script {
docker.withRegistry( '', registryCredential ) {
dockerImage.push()
}
}
}
}
/*
stage('Docker Run') {
steps {
  sh 'docker run -itd -p 8000:80 rakshithapapu7/portfolio-site:latest'
}
}
*/
  stage('Apply Kubernetes files') {
    steps{
    sh 'mkdir -p $HOME/.kube'
  sh 'sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config'
  sh 'sudo chown $(id -u):$(id -g) $HOME/.kube/config'
    sh 'kubectl apply -f portfolio.yaml'
    }
}
stage('Cleaning up local repository') {
steps{
sh "docker rmi $registry:$BUILD_NUMBER"
}
}
}
}
