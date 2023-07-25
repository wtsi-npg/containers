TAG=$(shell git describe --always)
ifeq ($(GITHUB_ACTIONS),true)
DOCKER_REGISTRY?=ghcr.io
DOCKER_USER?=$(GITHUB_REPOSITORY_OWNER)
else
DOCKER_REGISTRY?=docker.io
DOCKER_USER?=wsinpg
endif

NOW=$(shell date --utc --iso-8601=seconds)

DOCKER_PREFIX?=$(DOCKER_REGISTRY)/$(DOCKER_USER)
DOCKER_ARGS ?= --platform linux/amd64 --progress=plain --rm

.PHONY: clean push

image_names := ub-16.04-base ub-18.04-base
image_names += ub-16.04-irods-4.2.7
image_names += ub-18.04-irods-4.2.11
image_names += ub-18.04-irods-4.2.12
image_names += ub-18.04-irods-4.3.0

image_names += ub-18.04-irods-clients-dev-4.2.11
image_names += ub-18.04-irods-clients-dev-4.2.12
image_names += ub-18.04-irods-clients-dev-4.3.0
image_names += ub-20.04-irods-clients-dev-4.3.0

image_names += ub-18.04-irods-clients-4.2.11
image_names += ub-18.04-irods-clients-4.2.12

image_names += centos-7-base
image_names += centos-7-conda
image_names += centos-7-conda-build

image_names += md-bullseye-base
image_names += md-bullseye-conda

git_url=$(shell git remote get-url origin)
git_commit=$(shell git log --pretty=format:'%H' -n 1)

images := $(addsuffix .$(TAG), $(image_names))
remote := $(addsuffix .$(TAG).pushed, $(image_names))

all: $(images)

push: $(remote)

centos-7-base.$(TAG): base/centos/7/Dockerfile
	docker build $(DOCKER_ARGS) \
	--build-arg DOCKER_PREFIX=$(DOCKER_PREFIX) \
	--label org.opencontainers.image.title="Base image, CentOS 7" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/centos-7-base:latest \
	--tag $(DOCKER_PREFIX)/centos-7-base:$(TAG) --file $< ./base
	touch $@

ub-16.04-base.$(TAG): base/ubuntu/16.04/Dockerfile
	docker build $(DOCKER_ARGS) \
	--build-arg DOCKER_PREFIX=$(DOCKER_PREFIX) \
	--label org.opencontainers.image.title="Base image, Ubuntu 16.04" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/ub-16.04-base:latest \
	--tag $(DOCKER_PREFIX)/ub-16.04-base:$(TAG) --file $< ./base
	touch $@

ub-18.04-base.$(TAG): base/ubuntu/18.04/Dockerfile
	docker build $(DOCKER_ARGS) \
	--build-arg DOCKER_PREFIX=$(DOCKER_PREFIX) \
	--label org.opencontainers.image.title="Base image, Ubuntu 18.04" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/ub-18.04-base:latest \
	--tag $(DOCKER_PREFIX)/ub-18.04-base:$(TAG) --file $< ./base
	touch $@

md-bullseye-base.$(TAG): base/minideb/bullseye/Dockerfile
	docker build $(DOCKER_ARGS) \
	--build-arg DOCKER_PREFIX=$(DOCKER_PREFIX) \
	--label org.opencontainers.image.title="Base image, Debian bullseye" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/md-bullseye-base:latest \
	--tag $(DOCKER_PREFIX)/md-bullseye-base:$(TAG) --file $< ./base
	touch $@

centos-7-conda.$(TAG): conda/centos/7/Dockerfile centos-7-base.$(TAG)
	docker build $(DOCKER_ARGS) \
	--build-arg DOCKER_PREFIX=$(DOCKER_PREFIX) \
	--label org.opencontainers.image.title="Conda application, CentOS 7" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/centos-7-conda:latest \
	--tag $(DOCKER_PREFIX)/centos-7-conda:$(TAG) --file $< ./conda
	touch $@

centos-7-conda-build.$(TAG): conda/centos/7/build/Dockerfile centos-7-conda.$(TAG)
	docker build $(DOCKER_ARGS) \
	--build-arg DOCKER_PREFIX=$(DOCKER_PREFIX) \
	--label org.opencontainers.image.title="Conda package building, CentOS 7" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/centos-7-conda-build:latest \
	--tag $(DOCKER_PREFIX)/centos-7-conda-build:$(TAG) --file $< ./conda
	touch $@

md-bullseye-conda.$(TAG): conda/minideb/bullseye/Dockerfile md-bullseye-base.$(TAG)
	docker build $(DOCKER_ARGS) \
	--build-arg DOCKER_PREFIX=$(DOCKER_PREFIX) \
	--label org.opencontainers.image.title="Conda application, Debian bullseye" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/md-bullseye-conda:latest \
	--tag $(DOCKER_PREFIX)/md-bullseye-conda:$(TAG) --file $< ./conda
	touch $@

ub-16.04-irods-4.2.7.$(TAG): irods/ubuntu/16.04/Dockerfile ub-16.04-base.$(TAG)
	docker build $(DOCKER_ARGS) \
	--build-arg DOCKER_PREFIX=$(DOCKER_PREFIX) \
	--label org.opencontainers.image.title="iRODS 4.2.7 server, Ubuntu 16.04" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/ub-16.04-irods-4.2.7:latest \
	--tag $(DOCKER_PREFIX)/ub-16.04-irods-4.2.7:$(TAG) --file $< ./irods
	touch $@

ub-18.04-irods-4.2.11.$(TAG): irods/ubuntu/18.04/Dockerfile ub-18.04-base.$(TAG)
	docker build $(DOCKER_ARGS) \
	--build-arg DOCKER_PREFIX=$(DOCKER_PREFIX) \
	--build-arg IRODS_VERSION=4.2.11 \
	--label org.opencontainers.image.title="iRODS 4.2.11 server, Ubuntu 18.04" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/ub-18.04-irods-4.2.11:latest \
	--tag $(DOCKER_PREFIX)/ub-18.04-irods-4.2.11:$(TAG) --file $< ./irods
	touch $@

ub-18.04-irods-4.2.12.$(TAG): irods/ubuntu/18.04/Dockerfile ub-18.04-base.$(TAG)
	docker build $(DOCKER_ARGS) \
	--build-arg DOCKER_PREFIX=$(DOCKER_PREFIX) \
	--build-arg IRODS_VERSION=4.2.12 \
	--label org.opencontainers.image.title="iRODS 4.2.12 server, Ubuntu 18.04" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/ub-18.04-irods-4.2.12:latest \
	--tag $(DOCKER_PREFIX)/ub-18.04-irods-4.2.12:$(TAG) --file $< ./irods
	touch $@

ub-18.04-irods-4.3.0.$(TAG): irods/ubuntu/18.04/Dockerfile ub-18.04-base.$(TAG)
	docker build $(DOCKER_ARGS) \
	--build-arg DOCKER_PREFIX=$(DOCKER_PREFIX) \
	--build-arg IRODS_VERSION=4.3.0 \
	--label org.opencontainers.image.title="iRODS 4.3.0 server, Ubuntu 18.04" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/ub-18.04-irods-4.3.0:latest \
	--tag $(DOCKER_PREFIX)/ub-18.04-irods-4.3.0:$(TAG) --file $< ./irods
	touch $@

ub-18.04-irods-clients-4.2.11.$(TAG): irods_clients/ubuntu/Dockerfile ub-18.04-base.$(TAG)
	docker buildx build $(DOCKER_ARGS) \
	--load \
	--build-context singularity=../singularity \
	--build-arg DOCKER_PREFIX=$(DOCKER_PREFIX) \
	--build-arg BASE_IMAGE=$(DOCKER_PREFIX)/ub-18.04-base \
	--build-arg DOCKER_IMAGE=$(subst .$(TAG),,$@) \
	--build-arg DOCKER_TAG=$(TAG) \
	--build-arg IRODS_VERSION=4.2.11 \
	--build-arg BATON_VERSION=4.1.0 \
	--build-arg HTSLIB_VERSION=1.18 \
	--build-arg SAMTOOLS_VERSION=1.18 \
	--label org.opencontainers.image.title="iRODS 4.2.11 clients, Ubuntu 18.04" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/ub-18.04-irods-clients-4.2.11:latest \
	--tag $(DOCKER_PREFIX)/ub-18.04-irods-clients-4.2.11:$(TAG) --file $< ./irods_clients
	touch $@

ub-18.04-irods-clients-dev-4.2.11.$(TAG): irods_clients_dev/ubuntu/Dockerfile
	docker buildx build $(DOCKER_ARGS) \
	--load \
	--build-context singularity=../singularity \
	--build-arg BASE_IMAGE=ubuntu:bionic \
	--build-arg DOCKER_IMAGE=$(subst .$(TAG),,$@) \
	--build-arg DOCKER_TAG=$(TAG) \
	--build-arg IRODS_VERSION=4.2.11 \
	--build-arg BATON_VERSION=4.1.0 \
	--build-arg HTSLIB_VERSION=1.18 \
	--build-arg SAMTOOLS_VERSION=1.18 \
	--label org.opencontainers.image.title="iRODS 4.2.11 client development, Ubuntu 18.04" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/ub-18.04-irods-clients-dev-4.2.11:latest \
	--tag $(DOCKER_PREFIX)/ub-18.04-irods-clients-dev-4.2.11:$(TAG) --file $< ./irods_clients_dev
	touch $@

ub-18.04-irods-clients-4.2.12.$(TAG): irods_clients/ubuntu/Dockerfile ub-18.04-base.$(TAG)
	docker buildx build $(DOCKER_ARGS) \
	--load \
	--build-context singularity=../singularity \
	--build-arg DOCKER_PREFIX=$(DOCKER_PREFIX) \
	--build-arg BASE_IMAGE=$(DOCKER_PREFIX)/ub-18.04-base \
	--build-arg DOCKER_IMAGE=$(subst .$(TAG),,$@) \
	--build-arg DOCKER_TAG=$(TAG) \
	--build-arg IRODS_VERSION=4.2.12 \
	--build-arg BATON_VERSION=4.1.0 \
	--build-arg HTSLIB_VERSION=1.18 \
	--build-arg SAMTOOLS_VERSION=1.18 \
	--label org.opencontainers.image.title="iRODS 4.2.12 clients, Ubuntu 18.04" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/ub-18.04-irods-clients-4.2.12:latest \
	--tag $(DOCKER_PREFIX)/ub-18.04-irods-clients-4.2.12:$(TAG) --file $< ./irods_clients
	touch $@

ub-18.04-irods-clients-dev-4.2.12.$(TAG): irods_clients_dev/ubuntu/Dockerfile
	docker buildx build $(DOCKER_ARGS) \
	--load \
	--build-context singularity=../singularity \
	--build-arg BASE_IMAGE=ubuntu:bionic \
	--build-arg DOCKER_IMAGE=$(subst .$(TAG),,$@) \
	--build-arg DOCKER_TAG=$(TAG) \
	--build-arg IRODS_VERSION=4.2.12 \
	--label org.opencontainers.image.title="iRODS 4.2.12 client development, Ubuntu 18.04" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/ub-18.04-irods-clients-dev-4.2.12:latest \
	--tag $(DOCKER_PREFIX)/ub-18.04-irods-clients-dev-4.2.12:$(TAG) --file $< ./irods_clients_dev
	touch $@

ub-18.04-irods-clients-dev-4.3.0.$(TAG): irods_clients_dev/ubuntu/Dockerfile
	docker buildx build $(DOCKER_ARGS) \
	--load \
	--build-context singularity=../singularity \
	--build-arg BASE_IMAGE=ubuntu:bionic \
	--build-arg DOCKER_IMAGE=$(subst .$(TAG),,$@) \
	--build-arg DOCKER_TAG=$(TAG) \
	--build-arg IRODS_VERSION=4.3.0 \
	--label org.opencontainers.image.title="iRODS 4.3.0 client development, Ubuntu 18.04" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/ub-18.04-irods-clients-dev-4.3.0:latest \
	--tag $(DOCKER_PREFIX)/ub-18.04-irods-clients-dev-4.3.0:$(TAG) --file $< ./irods_clients_dev
	touch $@

ub-20.04-irods-clients-dev-4.3.0.$(TAG): irods_clients_dev/ubuntu/Dockerfile
	docker buildx build $(DOCKER_ARGS) \
	--load \
	--build-context singularity=../singularity \
	--build-arg DOCKER_PREFIX=$(DOCKER_PREFIX) \
	--build-arg BASE_IMAGE=ubuntu:focal \
	--build-arg IRODS_VERSION=4.3.0 \
	--build-arg DOCKER_IMAGE=$(subst .$(TAG),,$@) \
	--build-arg DOCKER_TAG=$(TAG) \
	--label org.opencontainers.image.title="iRODS 4.3.0 client development, Ubuntu 20.04" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/ub-20.04-irods-clients-dev-4.3.0:latest \
	--tag $(DOCKER_PREFIX)/ub-20.04-irods-clients-dev-4.3.0:$(TAG) --file $< ./irods_clients_dev
	touch $@

%.$(TAG).pushed: %.$(TAG)
	docker push $(DOCKER_PREFIX)/$*:$(TAG)
	docker push $(DOCKER_PREFIX)/$*:latest
	touch $@

remote-clean:
	rm -f $(remote)

clean:
	rm -f $(foreach image_name,$(image_names), $(image_name)*)
