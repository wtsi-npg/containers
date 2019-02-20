TAG=$(shell git describe)
LABEL_NAMESPACE=uk.ac.sanger
TAG_NAMESPACE=wsinpg

.PHONY: clean

image_names := ubuntu-12.04-base conda-12.04 conda-irods-12.04
images := $(addsuffix .$(TAG), $(image_names))

all: $(images)

ubuntu-12.04-base.$(TAG): base/ubuntu/12.04/Dockerfile
	docker build \
	--label $(LABEL_NAMESPACE).repository=$(shell git remote get-url origin) \
	--label $(LABEL_NAMESPACE).commit=$(shell git log --pretty=format:'%H' -n 1) \
	--tag $(TAG_NAMESPACE)/ubuntu-12.04-base:latest \
	--tag $(TAG_NAMESPACE)/ubuntu-12.04-base:$(TAG) --file $< ./base
	touch $@

conda-12.04.$(TAG): conda/ubuntu/12.04/Dockerfile ubuntu-12.04-base.$(TAG)
	docker build \
	--label $(LABEL_NAMESPACE).repository=$(shell git remote get-url origin) \
	--label $(LABEL_NAMESPACE).commit=$(shell git log --pretty=format:'%H' -n 1) \
	--tag $(TAG_NAMESPACE)/conda-12.04:latest \
	--tag $(TAG_NAMESPACE)/conda-12.04:$(TAG) --file $< ./conda
	touch $@

conda-irods-12.04.$(TAG): conda/ubuntu/12.04/Dockerfile.irods conda-12.04.$(TAG)
	docker build \
	--label $(LABEL_NAMESPACE).repository=$(shell git remote get-url origin) \
	--label $(LABEL_NAMESPACE).commit=$(shell git log --pretty=format:'%H' -n 1) \
	--tag $(TAG_NAMESPACE)/conda-irods-12.04:latest \
	--tag $(TAG_NAMESPACE)/conda-irods-12.04:$(TAG) --file $< ./conda
	touch $@

clean:
	rm $(images)
