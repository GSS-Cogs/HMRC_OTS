pipeline {
  agent {
      label 'master'
  }
  stages {
    stage('Transform') {
      agent {
        docker {
          image 'cloudfluff/databaker'
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
        docker {
          image 'cloudfluff/rdf-tabular'
          reuseNode true
        }
      }
      steps {
        sh 'cp metadata/*.json out/'
        sh 'rdf serialize --input-format tabular --output-format ttl out/eu_imports.csv > out/eu_imports.ttl'
      }
    }
    stage('Normalize Cube') {
      steps {
        sh 'java -cp bin/sparql uk.org.floop.updateInPlace.Run -q sparql-normalize out/eu_imports.ttl'
      }
    }
    stage('Test') {
      steps {
        sh 'java -cp bin/sparql uk.org.floop.sparqlTestRunner.Run -i -t tests/ports -r reports/TESTS-ports.xml out/airports.jsonld out/seaports.jsonld'
        sh 'java -cp bin/sparql uk.org.floop.sparqlTestRunner.Run -i -t tests/qb -r reports/TESTS-qb.xml out/eu_imports.ttl'
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