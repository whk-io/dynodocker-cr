build:
	crystal build src/dynodocker.cr --release
	./dynodocker -o Dockerfile -c
