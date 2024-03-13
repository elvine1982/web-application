node{
  def mavenHome = tool name: 'maven3.6.0'
  stage('1Clone'){
     git 'https://github.com/elvine1982/maven-web-application'
  }
  stage('2Test+build'){
    sh "${mavenHome}/bin/mvn clean package"
  }
*/
  stage('SonarQube'){
    sh "${mavenHome}/bin/mvn sonar:sonar"
  }
  stage('4UploadArtifacts'){
    sh "${mavenHome}/bin/mvn deploy"
  }
  stage('5Deploy'){
    deploy adapters: [tomcat9(credentialsId: 'tomcat-credentials', path: '', url: 'http://18.219.47.137:8177/')], contextPath: null, war: 'target/*war'
  }
  stage('6Notification'){
    emailext body: '''Hi Team,

Build status

Landmark2024''', recipientProviders: [contributor()], subject: 'builds', to: 'developers'
*/
  }
}
