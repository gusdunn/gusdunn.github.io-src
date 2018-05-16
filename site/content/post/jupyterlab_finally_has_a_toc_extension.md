+++
title = "Jupyter-Lab FINALLY has a TOC extension"
date = 2018-05-16T09:55:00-04:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["jupyter", "python", "jupyterlab", "jupyterlab-toc"]
categories = []

summary = "I can not overstate my appreciation to Ian Rose for finally allowing me to switch to JupyterLab as my primary interface to Jupyter Notebooks."

# Featured image
# Place your image in the `static/img/` folder and reference its filename below, e.g. `image = "example.jpg"`.
# Use `caption` to display an image caption.
#   Markdown linking is allowed, e.g. `caption = "[Image credit](http://example.org)"`.
# Set `preview` to `false` to disable the thumbnail in listings.
[header]
image = "posts/jupyterlab-toc.png"
caption = "https://github.com/ian-r-rose/jupyterlab-toc"
preview = true

+++

## Huzzah!

I can not overstate my appreciation to [Ian Rose](https://github.com/ian-r-rose) for finally allowing me to switch to [JupyterLab](https://blog.jupyter.org/jupyterlab-is-ready-for-users-5a6f039b8906) as my primary interface to Jupyter Notebooks.
I tried before but always returned to the old interface due to the fact that I heavily rely on headings to navigate my notebooks as I develop them.
My notebooks are usually pretty long and complex so the lack of a "navigation" system really impedes my productivity.

But no longer, thanks to [jupyterlab-toc](https://github.com/ian-r-rose/jupyterlab-toc)!

To install the extension run the following command:

```shell
$ jupyter labextension install jupyterlab-toc
```

When you restart your jupyterlab server, you will have a new sidebar tab named "Contents" which will open what you see below.

![toc](/img/posts/jupyterlab-toc-example.png)
