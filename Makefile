# this terminal directory will be a link to a separate instance of this repo.
# One with the gh-pages
DEPLOYMENT_REPO=dist-build/gusdunn.com
SITE_DIR=site

# Contents of CNAME file
CNAME="www.gusdunn.com\ngusdunn.com"

all: server

build: dist install-stuff

help:
	@echo "\033[0;4mAvailable targets:\033[0m"
	@echo " server - serves up site locally (default target)"
	@echo " build - build the content for deployment in ${DEPLOYMENT_REPO}"

view:
	# open front page in browser
	xdg-open http://localhost:1515

server: clean
	# Server the site up locally
	hugo server -s ${SITE_DIR} -w  --buildDrafts=true -p 1515

clean:
	# clean out the local server build artifacts
	-rm -r ${SITE_DIR}/public/*

dist: dist-clean
	# Build the project for publishing
	hugo -s ${SITE_DIR} -d ${DEPLOYMENT_REPO}

dist-clean:
	# clean publishing output dir
	# NB: Avoid removing the .git folder
	-rm -r ${SITE_DIR}/${DEPLOYMENT_REPO}/*

install-stuff:
	# install a CNAME file
	echo -e ${CNAME} > ${SITE_DIR}/${DEPLOYMENT_REPO}/CNAME
	# install the readme and license files
	cp README.md LICENSE.html ${SITE_DIR}/${DEPLOYMENT_REPO}/