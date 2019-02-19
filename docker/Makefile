VERSION=$(shell git describe)

.PHONY: ubuntu-12.04-base conda-12.04

LABEL_NAMESPACE=uk.ac.sanger
TAG_NAMESPACE=wsinpg

ubuntu-12.04-base: base/ubuntu/12.04/Dockerfile
	docker build \
	--label $(LABEL_NAMESPACE).repository=$(shell git remote get-url origin) \
	--label $(LABEL_NAMESPACE).commit=$(shell git log --pretty=format:'%H' -n 1) \
	--tag $(TAG_NAMESPACE)/$@:latest \
	--tag $(TAG_NAMESPACE)/$@:$(VERSION) --file $< ./base

conda-12.04: conda/ubuntu/12.04/Dockerfile
	docker build \
	--label $(LABEL_NAMESPACE).repository=$(shell git remote get-url origin) \
	--label $(LABEL_NAMESPACE).commit=$(shell git log --pretty=format:'%H' -n 1) \
	--tag $(TAG_NAMESPACE)/$@:latest \
	--tag $(TAG_NAMESPACE)/$@:$(VERSION) --file $< ./conda

conda-irods-12.04: conda/ubuntu/12.04/Dockerfile.irods
	docker build \
	--label $(LABEL_NAMESPACE).repository=$(shell git remote get-url origin) \
	--label $(LABEL_NAMESPACE).commit=$(shell git log --pretty=format:'%H' -n 1) \
	--tag $(TAG_NAMESPACE)/$@:latest \
	--tag $(TAG_NAMESPACE)/$@:$(VERSION) --file $< ./conda
