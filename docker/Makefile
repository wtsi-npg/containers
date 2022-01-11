TAG=$(shell git describe --always)
LABEL_NAMESPACE=uk.ac.sanger
ifdef REPO_OWNER
TAG_NAMESPACE?=ghcr.io/$(REPO_OWNER)
else
TAG_NAMESPACE?=wsinpg
endif

DOCKER_ARGS ?= --pull --no-cache # IMPORTANT to get security updates

.PHONY: clean

image_names := ub-16.04-base ub-18.04-base
image_names += ub-16.04-irods-4.2.7
image_names += ub-18.04-irods-4.2.10
image_names += ub-18.04-irods-4.2.11

image_names += centos-7-base
image_names += centos-7-conda

git_url=$(shell git remote get-url origin)
git_commit=$(shell git log --pretty=format:'%H' -n 1)

images := $(addsuffix .$(TAG), $(image_names))

all: $(images)

centos-7-base.$(TAG): base/centos/7/Dockerfile
	docker build $(DOCKER_ARGS) \
	--label $(LABEL_NAMESPACE).repository=$(git_url) \
	--label $(LABEL_NAMESPACE).commit=$(git_commit) \
	--tag $(TAG_NAMESPACE)/centos-7-base:latest \
	--tag $(TAG_NAMESPACE)/centos-7-base:$(TAG) --file $< ./base
	touch $@

ub-16.04-base.$(TAG): base/ubuntu/16.04/Dockerfile
	docker build $(DOCKER_ARGS) \
	--label $(LABEL_NAMESPACE).repository=$(git_url) \
	--label $(LABEL_NAMESPACE).commit=$(git_commit) \
	--tag $(TAG_NAMESPACE)/ub-16.04-base:latest \
	--tag $(TAG_NAMESPACE)/ub-16.04-base:$(TAG) --file $< ./base
	touch $@

ub-18.04-base.$(TAG): base/ubuntu/18.04/Dockerfile
	docker build $(DOCKER_ARGS) \
	--label $(LABEL_NAMESPACE).repository=$(git_url) \
	--label $(LABEL_NAMESPACE).commit=$(git_commit) \
	--tag $(TAG_NAMESPACE)/ub-18.04-base:latest \
	--tag $(TAG_NAMESPACE)/ub-18.04-base:$(TAG) --file $< ./base
	touch $@

centos-7-conda.$(TAG): conda/centos/7/Dockerfile centos-7-base.$(TAG)
	docker build $(DOCKER_ARGS) \
	--label $(LABEL_NAMESPACE).repository=$(git_url) \
	--label $(LABEL_NAMESPACE).commit=$(git_commit) \
	--tag $(TAG_NAMESPACE)/centos-7-conda:latest \
	--tag $(TAG_NAMESPACE)/centos-7-conda:$(TAG) --file $< ./conda
	touch $@

ub-16.04-irods-4.2.7.$(TAG): irods/ubuntu/16.04/Dockerfile ub-16.04-base.$(TAG)
	docker build $(DOCKER_ARGS) \
	--label $(LABEL_NAMESPACE).repository=$(git_url) \
	--label $(LABEL_NAMESPACE).commit=$(git_commit) \
	--tag $(TAG_NAMESPACE)/ub-16.04-irods-4.2.7:latest \
	--tag $(TAG_NAMESPACE)/ub-16.04-irods-4.2.7:$(TAG) --file $< ./irods
	touch $@

ub-18.04-irods-4.2.10.$(TAG): irods/ubuntu/18.04/Dockerfile ub-18.04-base.$(TAG)
	docker build $(DOCKER_ARGS) --build-arg IRODS_VERSION=4.2.10 \
	--label $(LABEL_NAMESPACE).repository=$(git_url) \
	--label $(LABEL_NAMESPACE).commit=$(git_commit) \
	--tag $(TAG_NAMESPACE)/ub-18.04-irods-4.2.10:latest \
	--tag $(TAG_NAMESPACE)/ub-18.04-irods-4.2.10:$(TAG) --file $< ./irods
	touch $@

ub-18.04-irods-4.2.11.$(TAG): irods/ubuntu/18.04/Dockerfile ub-18.04-base.$(TAG)
	docker build $(DOCKER_ARGS) --build-arg IRODS_VERSION=4.2.11 \
	--label $(LABEL_NAMESPACE).repository=$(git_url) \
	--label $(LABEL_NAMESPACE).commit=$(git_commit) \
	--tag $(TAG_NAMESPACE)/ub-18.04-irods-4.2.11:latest \
	--tag $(TAG_NAMESPACE)/ub-18.04-irods-4.2.11:$(TAG) --file $< ./irods
	touch $@


clean:
	rm -f $(foreach image_name,$(image_names), $(image_name)*)
