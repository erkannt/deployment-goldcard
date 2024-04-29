SHELL:=/bin/bash

KRM_SOURCES := $(shell find . -name '*.yaml' | grep -v expected.yaml)

.PHONY: diff
diff:
	diff expected.yaml <(kubectl kustomize demo)

expected.yaml: $(KRM_SOURCES)
	kubectl kustomize demo > $@