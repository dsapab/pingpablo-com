# CC-BY-SA-4.0
# 2026 Pablo - HUGO MAKEFILE

## 
# Sanity checks
AWSCLI:=$(shell command -v aws --version 2> /dev/null)

ifdef AWSCLI
AWSCLI:=aws
else
$(error "Did not find required AWS CLI executable!")
endif


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

	@echo -e "\n[OK] - Build completed successfully."

test: prechecks
	@echo -e "\n\nStarting test server..."
	@hugo server --minify --watch
	@echo -e "\n\nTest finished."

clean:
	@echo "\nCleaning..."
	@rm -rf ./public
	@rm -rf ./resources
	@hugo mod clean --all
	@echo "\n[OK] - Clean completed!"

all: site
	@echo -e "\n[OK] - Build completed!"
