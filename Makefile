# this terminal directory will be a link to a separate repo.
DEPLOYMENT_REPO="public"
SITE_DIR=site

# Contents of CNAME file
CNAME="www.gusdunn.com\ngusdunn.com"

all: serve

build: dist install-stuff

help:
	@echo "Available targets:"
	@echo " serve - serves up site locally (default target)"
	@echo " build - build the content for deployment."

view:
	# open front page in browser
	xdg-open http://localhost:1515

server: clean
	# Server the site up locally
	hugo server -s ${SITE_DIR} -w  --buildDrafts=true -p 1515

dist: clean
	# Build the project for publishing
	hugo -s ${SITE_DIR} -d ${DEPLOYMENT_REPO}

clean:
	# clean publishing output dir
	# NB: Avoid removing the .git folder
	-rm -r ${SITE_DIR}/${DEPLOYMENT_REPO}/*

install-stuff:
	# install a CNAME file
	echo -e ${CNAME} > ${SITE_DIR}/${DEPLOYMENT_REPO}/CNAME
	# install the readme and license files
	cp README.md LICENSE.html ${SITE_DIR}/${DEPLOYMENT_REPO}/

commit-public:
	cd public && \
	git commit -m "rebuilt site $$(date)" && \
	git push origin master
