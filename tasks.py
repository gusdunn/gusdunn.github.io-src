#!/usr/bin/env python
"""Provide automation logic for common project maintainance jobs."""
import inspect
from pathlib import Path
import datetime as dt

from invoke import task

PROJECT_DIR = Path(inspect.getfile(inspect.currentframe())).parent
SITE_DIR = PROJECT_DIR / 'site'
DEPLOYMENT_REPO = SITE_DIR / 'public'

CNAME = 'www.gusdunn.com\ngusdunn.com'


@task
def install(ctx):
    """Install the needed packages into a virtual environment."""
    ctx.run("pipenv install")


@task
def clean_deployment_repo(ctx):
    """Clean DEPLOYMENT_REPO of all files, but leave the .git dir and other required things."""
    ctx.run(f"""rm -rf {DEPLOYMENT_REPO}/*""")
    ctx.run(f"""echo '{CNAME}' > {DEPLOYMENT_REPO}/CNAME""")
    ctx.run(
        f"""cp {PROJECT_DIR}/README.md {PROJECT_DIR}/LICENSE.html {DEPLOYMENT_REPO}/"""
    )


@task(clean_deployment_repo)
def start_server(ctx):
    """Serve the site locally and watch for changes."""
    ctx.run(f"""hugo server -s {SITE_DIR} -w  --buildDrafts=true -p 1515""")


@task(clean_deployment_repo)
def dist(ctx):
    """Build the project for publishing."""
    ctx.run(f"""hugo -s {SITE_DIR} -d {DEPLOYMENT_REPO.stem}""")


@task(dist)
def deploy(ctx):
    """Build the latest content, commit and push content to DEPLOYMENT_REPO."""
    now = dt.datetime.now().isoformat()

    c_and_p_deploy = f"""cd {DEPLOYMENT_REPO} && """ \
                     """git add . && """ \
                     f"""git commit -m "rebuilt site {now}" && """ \
                     """git push origin master """

    commit_delta_submod = f"""cd {PROJECT_DIR} && """ \
                          f"""git commit site/public -m "built and pushed site to live: {now}" && """ \
                          """git push origin master"""

    ctx.run(c_and_p_deploy)
    ctx.run(commit_delta_submod)


@task
def update_theme(ctx):
    """Sync forked repo of the Academic theme with upstream."""
    ACADEMIC_DIR = PROJECT_DIR / "site/themes/academic"

    cmd = f"""cd {ACADEMIC_DIR} && """ \
          """git fetch upstream && """ \
          """git rebase upstream/master && """ \
          """git push && """ \
          f"""cd {PROJECT_DIR} && """ \
          """git add . && """ \
          """git commit -m "synced forked Academic theme with upstream  $(date)" && """ \
          """git push origin master"""

    ctx.run(cmd)
