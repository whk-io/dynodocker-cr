build:
	crystal build src/dynodocker.cr --release
	./dynodocker > Dockerfile
	cat Dockerfile
