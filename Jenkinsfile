pipeline {
  agent {
      label 'master'
  }
  stages {
    stage('Transform') {
      agent {
        dockerfile {
          args "-v ${env.WORKSPACE}:/workspace"
          reuseNode true
        }
      }
      steps {
        sh 'jupyter-nbconvert --to python --stdout Port_codes.ipynb | python'
        sh 'jupyter-nbconvert --to python --stdout OTS_import.ipynb | python'
      }
    }
    stage('CSV2RDF') {
      agent {
        dockerfile {
          filename "Dockerfile-rdf-tabular"
          args "-v ${env.WORKSPACE}:/workspace"
          reuseNode true
        }
      }
      steps {
        sh 'cp metadata/*.json out/'
        sh 'rdf-tabular rdf serialize --input-format tabular --output-format ttl out/eu_imports.csv > out/eu_imports.ttl'
      }
    }
    stage('Test') {
      steps {
        sh 'java -cp bin/sparql uk.org.floop.sparqlTestRunner.Run -t tests/ports -r reports/TESTS-ports.xml out/airports.jsonld out/seaports.jsonld || true'
        sh 'java -cp bin/sparql uk.org.floop.sparqlTestRunner.Run -t tests/qb -r reports/TESTS-qb.xml out/airports.jsonld out/seaports.jsonld || true'
      }
    }
  }
  post {
    always {
      archiveArtifacts 'out/*'
      junit 'reports/**/*.xml'
    }
  }
}