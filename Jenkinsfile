pipeline {
  agent {
    dockerfile {
      label 'databaker-jupyter'
      args "-v ${PWD}:/workspace"
    }
  }
  stages {
    stage{'Transform'} {
      steps {
        sh 'jupyter-nbconvert --to python --stdout Port_codes.ipynb  | python'
      }
    }
  }
}