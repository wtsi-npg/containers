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

image_names := ub-16.04-base ub-18.04-base ub-22.04-base

image_names += ub-16.04-irods-4.2.7
image_names += ub-18.04-irods-4.2.11
image_names += ub-18.04-irods-4.2.12
image_names += ub-18.04-irods-4.3.0
image_names += ub-22.04-irods-4.3-nightly

image_names += ub-16.04-irods-clients-dev-4.2.7
image_names += ub-18.04-irods-clients-dev-4.2.11
image_names += ub-18.04-irods-clients-dev-4.2.12
image_names += ub-18.04-irods-clients-dev-4.3.0
image_names += ub-20.04-irods-clients-dev-4.3.0
image_names += ub-22.04-irods-clients-dev-4.3-nightly

image_names += ub-16.04-irods-clients-4.2.7
image_names += ub-18.04-irods-clients-4.2.11
image_names += ub-18.04-irods-clients-4.2.12
image_names += ub-22.04-irods-clients-4.3-nightly

git_url=$(shell git remote get-url origin)
git_commit=$(shell git log --pretty=format:'%H' -n 1)

images := $(addsuffix .$(TAG), $(image_names))
remote := $(addsuffix .$(TAG).pushed, $(image_names))

all: $(images)

push: $(remote)

ub-16.04-base.$(TAG): base/ubuntu/16.04/Dockerfile
	docker buildx build $(DOCKER_ARGS) \
	--load \
	--label org.opencontainers.image.title="Base image, Ubuntu 16.04" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/ub-16.04-base:latest \
	--tag $(DOCKER_PREFIX)/ub-16.04-base:$(TAG) --file $< ./base
	touch $@

ub-18.04-base.$(TAG): base/ubuntu/18.04/Dockerfile
	docker buildx build $(DOCKER_ARGS) \
	--load \
	--label org.opencontainers.image.title="Base image, Ubuntu 18.04" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/ub-18.04-base:latest \
	--tag $(DOCKER_PREFIX)/ub-18.04-base:$(TAG) --file $< ./base
	touch $@

ub-22.04-base.$(TAG): base/ubuntu/22.04/Dockerfile
	docker buildx build $(DOCKER_ARGS) \
	--load \
	--label org.opencontainers.image.title="Base image, Ubuntu 22.04" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/ub-22.04-base:latest \
	--tag $(DOCKER_PREFIX)/ub-22.04-base:$(TAG) --file $< ./base
	touch $@

ub-16.04-irods-4.2.7.$(TAG): irods/ubuntu/16.04/Dockerfile ub-16.04-base.$(TAG)
	docker buildx build $(DOCKER_ARGS) \
	--load \
	--build-arg BASE_IMAGE=$(DOCKER_PREFIX)/ub-16.04-base \
	--label org.opencontainers.image.title="iRODS 4.2.7 server, Ubuntu 16.04" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/ub-16.04-irods-4.2.7:latest \
	--tag $(DOCKER_PREFIX)/ub-16.04-irods-4.2.7:$(TAG) --file $< ./irods
	touch $@

ub-18.04-irods-4.2.11.$(TAG): irods/ubuntu/18.04/Dockerfile ub-18.04-base.$(TAG)
	docker buildx build $(DOCKER_ARGS) \
	--load \
	--build-arg BASE_IMAGE=$(DOCKER_PREFIX)/ub-18.04-base \
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
	docker buildx build $(DOCKER_ARGS) \
	--load \
	--build-arg BASE_IMAGE=$(DOCKER_PREFIX)/ub-18.04-base \
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
	docker buildx build $(DOCKER_ARGS) \
	--load \
	--build-arg BASE_IMAGE=$(DOCKER_PREFIX)/ub-18.04-base \
	--build-arg IRODS_VERSION=4.3.0 \
	--label org.opencontainers.image.title="iRODS 4.3.0 server, Ubuntu 18.04" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/ub-18.04-irods-4.3.0:latest \
	--tag $(DOCKER_PREFIX)/ub-18.04-irods-4.3.0:$(TAG) --file $< ./irods
	touch $@

ub-22.04-irods-4.3-nightly.$(TAG): irods/ubuntu/22.04/Dockerfile ub-22.04-base.$(TAG)
	docker buildx build $(DOCKER_ARGS) \
	--load \
	--build-arg BASE_IMAGE=$(DOCKER_PREFIX)/ub-22.04-base \
	--build-arg IRODS_VERSION=4.3-nightly \
	--label org.opencontainers.image.title="iRODS 4.3-nightly server, Ubuntu 22.04" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/ub-22.04-irods-4.3-nightly:latest \
	--tag $(DOCKER_PREFIX)/ub-22.04-irods-4.3-nightly:$(TAG) --file $< ./irods
	touch $@

ub-16.04-irods-clients-4.2.7.$(TAG): irods_clients/ubuntu/16.04/Dockerfile ub-16.04-base.$(TAG)
	docker buildx build $(DOCKER_ARGS) \
	--load \
	--build-context singularity=../singularity \
	--build-arg BASE_IMAGE=$(DOCKER_PREFIX)/ub-16.04-base \
	--build-arg DOCKER_IMAGE=$(subst .$(TAG),,$@) \
	--build-arg DOCKER_TAG=$(TAG) \
	--build-arg IRODS_VERSION=4.2.7 \
	--build-arg BATON_VERSION=4.2.1 \
	--build-arg HTSLIB_VERSION=1.18 \
	--build-arg SAMTOOLS_VERSION=1.18 \
	--build-arg BCFTOOLS_VERSION=1.18 \
	--label org.opencontainers.image.title="iRODS 4.2.7 clients, Ubuntu 16.04" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/ub-16.04-irods-clients-4.2.7:latest \
	--tag $(DOCKER_PREFIX)/ub-16.04-irods-clients-4.2.7:$(TAG) --file $< ./irods_clients
	touch $@

ub-18.04-irods-clients-4.2.11.$(TAG): irods_clients/ubuntu/Dockerfile ub-18.04-base.$(TAG)
	docker buildx build $(DOCKER_ARGS) \
	--load \
	--build-context singularity=../singularity \
	--build-arg BASE_IMAGE=$(DOCKER_PREFIX)/ub-18.04-base \
	--build-arg DOCKER_IMAGE=$(subst .$(TAG),,$@) \
	--build-arg DOCKER_TAG=$(TAG) \
	--build-arg IRODS_VERSION=4.2.11 \
	--build-arg BATON_VERSION=4.2.1 \
	--build-arg HTSLIB_VERSION=1.18 \
	--build-arg SAMTOOLS_VERSION=1.18 \
	--build-arg BCFTOOLS_VERSION=1.18 \
	--label org.opencontainers.image.title="iRODS 4.2.11 clients, Ubuntu 18.04" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/ub-18.04-irods-clients-4.2.11:latest \
	--tag $(DOCKER_PREFIX)/ub-18.04-irods-clients-4.2.11:$(TAG) --file $< ./irods_clients
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
	--build-arg BATON_VERSION=4.2.1 \
	--build-arg HTSLIB_VERSION=1.18 \
	--build-arg SAMTOOLS_VERSION=1.18 \
	--build-arg BCFTOOLS_VERSION=1.18 \
	--label org.opencontainers.image.title="iRODS 4.2.12 clients, Ubuntu 18.04" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/ub-18.04-irods-clients-4.2.12:latest \
	--tag $(DOCKER_PREFIX)/ub-18.04-irods-clients-4.2.12:$(TAG) --file $< ./irods_clients
	touch $@

ub-22.04-irods-clients-4.3-nightly.$(TAG): irods_clients/ubuntu/22.04/Dockerfile
	docker buildx build $(DOCKER_ARGS) \
	--load \
	--build-context singularity=../singularity \
	--build-arg DOCKER_PREFIX=$(DOCKER_PREFIX) \
	--build-arg BASE_IMAGE=$(DOCKER_PREFIX)/ub-22.04-base \
	--build-arg DOCKER_IMAGE=$(subst .$(TAG),,$@) \
	--build-arg DOCKER_TAG=$(TAG) \
	--build-arg IRODS_VERSION=4.3-nightly \
	--build-arg BATON_VERSION=4.2.1 \
	--build-arg HTSLIB_VERSION=1.18 \
	--build-arg SAMTOOLS_VERSION=1.18 \
	--build-arg BCFTOOLS_VERSION=1.18 \
	--label org.opencontainers.image.title="iRODS 4.3-nightly clients, Ubuntu 22.04" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/ub-22.04-irods-clients-4.3-nightly:latest \
	--tag $(DOCKER_PREFIX)/ub-22.04-irods-clients-4.3-nightly:$(TAG) --file $< ./irods_clients
	touch $@

ub-16.04-irods-clients-dev-4.2.7.$(TAG): irods_clients_dev/ubuntu/16.04/Dockerfile
	docker buildx build $(DOCKER_ARGS) \
	--load \
	--build-context singularity=../singularity \
	--build-arg BASE_IMAGE=ubuntu:16.04 \
	--build-arg DOCKER_IMAGE=$(subst .$(TAG),,$@) \
	--build-arg DOCKER_TAG=$(TAG) \
	--build-arg IRODS_VERSION=4.2.7 \
	--label org.opencontainers.image.title="iRODS 4.2.7 client development, Ubuntu 16.04" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/ub-16.04-irods-clients-dev-4.2.7:latest \
	--tag $(DOCKER_PREFIX)/ub-16.04-irods-clients-dev-4.2.7:$(TAG) --file $< ./irods_clients_dev
	touch $@

ub-18.04-irods-clients-dev-4.2.11.$(TAG): irods_clients_dev/ubuntu/Dockerfile
	docker buildx build $(DOCKER_ARGS) \
	--load \
	--build-context singularity=../singularity \
	--build-arg BASE_IMAGE=ubuntu:18.04 \
	--build-arg DOCKER_IMAGE=$(subst .$(TAG),,$@) \
	--build-arg DOCKER_TAG=$(TAG) \
	--build-arg IRODS_VERSION=4.2.11 \
	--label org.opencontainers.image.title="iRODS 4.2.11 client development, Ubuntu 18.04" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/ub-18.04-irods-clients-dev-4.2.11:latest \
	--tag $(DOCKER_PREFIX)/ub-18.04-irods-clients-dev-4.2.11:$(TAG) --file $< ./irods_clients_dev
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
	--build-arg BASE_IMAGE=ubuntu:20.04 \
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

ub-22.04-irods-clients-dev-4.3-nightly.$(TAG): irods_clients_dev/ubuntu/22.04/Dockerfile
	docker buildx build $(DOCKER_ARGS) \
	--load \
	--build-context singularity=../singularity \
	--build-arg DOCKER_PREFIX=$(DOCKER_PREFIX) \
	--build-arg BASE_IMAGE=ubuntu:22.04 \
	--build-arg IRODS_VERSION=4.3-nightly \
	--build-arg DOCKER_IMAGE=$(subst .$(TAG),,$@) \
	--build-arg DOCKER_TAG=$(TAG) \
	--label org.opencontainers.image.title="iRODS 4.3-nightly client development, Ubuntu 22.04" \
	--label org.opencontainers.image.source=$(git_url) \
	--label org.opencontainers.image.revision=$(git_commit) \
	--label org.opencontainers.image.version=$(TAG) \
	--label org.opencontainers.image.created=$(NOW) \
	--tag $(DOCKER_PREFIX)/ub-22.04-irods-clients-dev-4.3-nightly:latest \
	--tag $(DOCKER_PREFIX)/ub-22.04-irods-clients-dev-4.3-nightly:$(TAG) --file $< ./irods_clients_dev
	touch $@

%.$(TAG).pushed: %.$(TAG)
	docker push $(DOCKER_PREFIX)/$*:$(TAG)
	docker push $(DOCKER_PREFIX)/$*:latest
	touch $@

remote-clean:
	rm -f $(remote)

clean:
	rm -f $(foreach image_name,$(image_names), $(image_name)*)
