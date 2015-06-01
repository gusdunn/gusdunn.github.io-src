# this terminal directory will be a link to a separate instance of this repo.
# One with the gh-pages
DEPLOYMENT_REPO=dist-build/gusdunn.com

# Contents of CNAME file
CNAME="gusdunn.com"

all: server

build: dist

help:
	@echo "\033[0;4mAvailable targets:\033[0m"
	@echo " server - serves up site locally (default target)"
	@echo " build - build the content for deployment in ${DEPLOYMENT_REPO}"

view:
	# open front page in browser
	xdg-open http://localhost:1313

server: clean
	# Server the site up locally
	hugo server -s site -w  --buildDrafts=true

clean:
	# clean out the local server build artifacts
	-rm -r site/public/*

dist: dist-clean
	# Build the project for publishing
	hugo -s site -d ${DEPLOYMENT_REPO}
	# replace the CNAME file after cleaning
	echo ${CNAME} > site/${DEPLOYMENT_REPO}/CNAME

dist-clean:
	# clean publishing output dir
	# NB: Avoid removing the .git folder
	-rm -r site/${DEPLOYMENT_REPO}/*

