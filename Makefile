out/eu_imports.ttl: out/eu_imports.csv metadata/eu_imports.csv-metadata.json
	cp metadata/eu_imports.csv-metadata.json out/
	docker run -v "$(CURDIR)":/data:z -it rdf-tabular rdf serialize --input-format tabular --output-format turtle /data/out/eu_imports.csv > out/eu_imports.ttl

test: out/eu_imports.ttl
	java -cp bin/sparql uk.org.floop.sparqlTestRunner.Run -i -t tests/qb -r reports/TESTS-qb.xml out/eu_imports.ttl
	java -cp bin/sparql uk.org.floop.sparqlTestRunner.Run -i -t tests/vocabs -r reports/TESTS-vocabs.xml out/eu_imports.ttl vocabs/*
