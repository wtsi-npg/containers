TAG=$(shell git describe)
LABEL_NAMESPACE=uk.ac.sanger
TAG_NAMESPACE=wsinpg

.PHONY: clean

image_names := ub-12.04-base ub-12.04-conda ub-12.04-conda-irods-4.1 # ub-12.04-conda-irods-4.2
images := $(addsuffix .$(TAG), $(image_names))

all: $(images)

ub-12.04-base.$(TAG): base/ubuntu/12.04/Dockerfile
	docker build \
	--label $(LABEL_NAMESPACE).repository=$(shell git remote get-url origin) \
	--label $(LABEL_NAMESPACE).commit=$(shell git log --pretty=format:'%H' -n 1) \
	--tag $(TAG_NAMESPACE)/ub-12.04-base:latest \
	--tag $(TAG_NAMESPACE)/ub-12.04-base:$(TAG) --file $< ./base
	touch $@

ub-12.04-conda.$(TAG): conda/ubuntu/12.04/Dockerfile ub-12.04-base.$(TAG)
	docker build \
	--label $(LABEL_NAMESPACE).repository=$(shell git remote get-url origin) \
	--label $(LABEL_NAMESPACE).commit=$(shell git log --pretty=format:'%H' -n 1) \
	--tag $(TAG_NAMESPACE)/ub-12.04-conda:latest \
	--tag $(TAG_NAMESPACE)/ub-12.04-conda:$(TAG) --file $< ./conda
	touch $@

ub-12.04-conda-irods-4.1.$(TAG): conda/ubuntu/12.04/Dockerfile.irods-4.1.2 ub-12.04-conda.$(TAG)
	docker build \
	--label $(LABEL_NAMESPACE).repository=$(shell git remote get-url origin) \
	--label $(LABEL_NAMESPACE).commit=$(shell git log --pretty=format:'%H' -n 1) \
	--tag $(TAG_NAMESPACE)/ub-12.04-conda-irods-4.1:latest \
	--tag $(TAG_NAMESPACE)/ub-12.04-conda-irods-4.1:$(TAG) --file $< ./conda
	touch $@

ub-12.04-conda-irods-4.2.$(TAG): conda/ubuntu/12.04/Dockerfile.irods-4.2.5 ub-12.04-conda.$(TAG)
	docker build \
	--label $(LABEL_NAMESPACE).repository=$(shell git remote get-url origin) \
	--label $(LABEL_NAMESPACE).commit=$(shell git log --pretty=format:'%H' -n 1) \
	--tag $(TAG_NAMESPACE)/ub-12.04-conda-irods-4.2:latest \
	--tag $(TAG_NAMESPACE)/ub-12.04-conda-irods-4.2:$(TAG) --file $< ./conda
	touch $@

clean:
	rm $(images)
