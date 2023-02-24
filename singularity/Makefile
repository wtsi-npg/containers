TAG?=$(shell git describe --always)
DOCKER_REGISTRY?=docker.io
DOCKER_USER?=wsinpg
DOCKER_PREFIX?=$(DOCKER_REGISTRY)/$(DOCKER_USER)
DOCKER_IMAGE?=ub-18.04-irods-clients-4.2.11

PREFIX?=/usr/local

.PHONY: clean install

clients := iadmin ibun ichksum ichmod icp idbug ienv ierror iexecmd \
    iexit ifsck iget igroupadmin ihelp iinit ils ilsresc imcoll imeta \
    imiscsvrinfo imkdir imv ipasswd iphybun iphymv ips iput ipwd iqdel \
    iqmod iqstat iquest iquota irepl irm irmdir irmtrash irsync irule \
	iscan isysmeta iticket itrim iuserinfo ixmsg izonereport \
	baton-chmod baton-do baton-get baton-list baton-metamod baton-metaquery baton-put

all: $(clients)

$(clients):
	for name in "$@" ; do DOCKER_PREFIX=$(DOCKER_PREFIX) DOCKER_IMAGE=$(DOCKER_IMAGE) TAG=$(TAG) EXECUTABLE="$$name" ./scripts/make_wrapper.sh ; done

install: $(clients)
	install -d $(PREFIX)/bin
	install $(clients) $(PREFIX)/bin
	install ./scripts/singularity-run-docker $(PREFIX)/bin

clean:
	rm $(clients)
