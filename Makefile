# this terminal directory will be a link to a separate repo.
DEPLOYMENT_REPO="public"
SITE_DIR=site

# Contents of CNAME file
CNAME="www.gusdunn.com\ngusdunn.com"

all: serve

deploy: dist install-stuff
	./deploy.sh

help:
	@echo "Available targets:"
	@echo " serve - serves up site locally (default target)"
	@echo " deploy - build the content for deployment, commit and push rendered site to github."

view:
	# open front page in browser
	xdg-open http://localhost:1515

serve: clean
	# Serve the site up locally
	hugo server -s ${SITE_DIR} -w  --buildDrafts=true -p 1515

dist: clean
	# Build the project for publishing
	hugo -s ${SITE_DIR} -d ${DEPLOYMENT_REPO}

clean:
	# clean publishing output dir
	# NB: Avoid removing the .git folder
	-rm -rf ${SITE_DIR}/${DEPLOYMENT_REPO}/*

install-stuff:
	# install a CNAME file
	echo -e ${CNAME} > ${SITE_DIR}/${DEPLOYMENT_REPO}/CNAME
	# install the readme and license files
	cp README.md LICENSE.html ${SITE_DIR}/${DEPLOYMENT_REPO}/
