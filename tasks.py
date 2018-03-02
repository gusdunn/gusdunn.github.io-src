#!/usr/bin/env python
"""Provide automation logic for common project maintainance jobs."""
from pathlib import Path

from invoke import task

PROJECT_DIR = Path('.').resolve()
SITE_DIR = PROJECT_DIR / 'site'
DEPLOYMENT_REPO = PROJECT_DIR / SITE_DIR / 'public'

CNAME = 'www.gusdunn.com\ngusdunn.com'


@task
def clean_deployment_repo(ctx):
    """Clean ``DEPLOYMENT_REPO`` of all files, but leave the ``.git`` dir and other required things."""
    ctx.run(f"""rm -rf {DEPLOYMENT_REPO}/*""")
    ctx.run(f"""echo '{CNAME}' > {DEPLOYMENT_REPO}/CNAME""")
    ctx.run(f"""cp {PROJECT_DIR}/README.md {PROJECT_DIR}/LICENSE.html {DEPLOYMENT_REPO}/""")


@task(clean_deployment_repo)
def start_server(ctx):
    """Serve the site locally and watch for changes."""
    ctx.run(f"""hugo server -s {SITE_DIR} -w  --buildDrafts=true -p 1515""")


@task(clean_deployment_repo)
def dist(ctx):
    """Build the project for publishing."""
    ctx.run(f"""hugo -s {SITE_DIR} -d {DEPLOYMENT_REPO.stem}""")


@task
def deploy(ctx):
    """Build the latest content, """