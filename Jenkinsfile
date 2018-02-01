pipeline {
  agent {
    dockerfile {
      args "-v ${env.WORKSPACE}:/workspace"
    }
  }
  stages {
    stage('Transform') {
      steps {
        sh 'jupyter-nbconvert --to python --stdout Port_codes.ipynb  | python'
      }
    }
  }
}