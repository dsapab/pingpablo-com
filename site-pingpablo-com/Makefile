# CC-BY-SA-4.0
# 2026 Pablo - HUGO MAKEFILE

HUGO_VERSION := v0.156.0
PAGEFIND_VERSION := 1.4.0

## 
# Sanity checks
JQ:=$(shell command -v jq 2> /dev/null)
PYTHON3:=$(shell command -v python3 2> /dev/null)
AWSCLI:=$(shell command -v aws --version 2> /dev/null)

ifdef JQ
JQ:=jq
else
$(error "Did not find required jq executable!")
endif

ifdef PYTHON3
PYTHON3:=python3
else
$(error "Did not find required python3 executable!")
endif

ifdef AWSCLI
AWSCLI:=aws
else
$(error "Did not find required AWS CLI executable!")
endif

## 
# PHONY Targets - will always run
.PHONY: prechecks site test clean newpost install buildindex

## 
# Targets
prechecks:
	@echo -e "\nRunning prechecks..."
	@./tools/check-categories.sh
	@echo -e "[OK] - Prechecks passed\n"

site: prechecks
	@echo -e "\nBuilding site..."

	@if [ -n "$${BASE_URL}" ]; then 					 \
		echo -e "\nBuilding with base URL $${BASE_URL}"; \
		hugo --minify --baseURL $${BASE_URL}; 			 \
	else \
		echo -e "\nBuilding without base URL..."; 		 \
		hugo --minify; 									 \
	fi

	@if [ $$? -ne 0 ] ; then					\
		echo -e "\n[ERROR] Build failed...";	\
		exit 1;									\
	fi

	@echo -e "\n[OK] - Build completed."

build: site buildindex
	@echo "\n[OK] - Site and index built successfully!"

test: build
	@echo -e "\n\nStarting test server..."
	@hugo server --minify --watch
	@echo -e "\n\nTest finished."

clean:
	@echo "\nCleaning..."
	@rm -rf ./public
	@rm -rf ./resources
	@hugo mod clean --all
	@echo "\n[OK] - Clean completed!"

newpost:
	@./tools/new-blog-post.sh
	@echo -e "\n[OK] - New post entry created!"

install:
	@./tools/install-hugo.sh $(HUGO_VERSION)

buildindex:
	@echo -e "\n\nBuilding search index..."
	@sleep 2
	@./tools/pagefind-build.sh $(PAGEFIND_VERSION)
	@echo -e "\n[OK] - Index creation completed!"

all: site
	@echo -e "\n[OK] - Build completed!"
