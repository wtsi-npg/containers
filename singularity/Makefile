URL=$(patsubst %@,%,$(shell git ls-remote --get-url origin))
TAG=$(shell git describe)

SINGULARITY_ARGS ?=

.PHONY: clean

image_names := baton-2.1.0

images := $(addsuffix .sif, $(image_names))

all: $(images)

baton-%.sif: baton/baton-%.def
	SINGULARITYENV_GIT_URL=$(URL) \
	SINGULARITYENV_GIT_REF=$(TAG) \
	singularity build $(SINGULARITY_ARGS) $@ $<

clean:
	rm -f $(foreach image_name,$(image_names), $(image_name).sif)
