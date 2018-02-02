pipeline {
  agent any
  stages {
    stage('Transform') {
      agent {
        dockerfile {
          args "-v ${env.WORKSPACE}:/workspace"
        }
      }
      steps {
        sh 'jupyter-nbconvert --to python --stdout Port_codes.ipynb  | python'
      }
    }
    stage('Test') {
      steps {
        sh 'java -cp bin/sparql uk.org.floop.sparqlTestRunner.Run -t tests/airports out/airports.jsonld'
      }
    }
  }
  post {
    always {
      junit 'reports/**/*.xml'
    }
  }
}