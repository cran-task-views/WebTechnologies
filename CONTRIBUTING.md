# Contributing Guidelines

Contributions to the Web Technologies task view are welcome from anyone and are best sent as pull requests on [the GitHub repository](https://github.com/cran-task-views/WebTechnologies). This page provides some instructions to potential contributors about how to add to the package.

1. Contributions can be submitted as [a pull request](https://help.github.com/articles/creating-a-pull-request/) on GitHub by forking or cloning the [repo](https://github.com/cran-task-views/WebTechnologies), making changes and submitting the pull request.

1. Pull requests should involve only one commit per substantive change. This means if you change multiple files (e.g., code and documentation), these changes should be committed together. If you don't know how to do this (e.g., you are making changes in the GitHub web interface) just submit anyway and the maintainer will clean things up.

1. Before submitting the pull request, please

    * run `ctv::ctv2html("WebTechnologies.md")` and open "WebTechnologies.html" (in the root directory) to inspect the rendered html
    * run `ctv::check_ctv_packages("WebTechnologies.md")`  to ensure consistency in all the links you added.

Some specific types of changes that you might make are:

1. *Fix broken links*. Great!

1. *Add new packages*. This is fine!

1. *Remove packages retired from CRAN*. OK but this should be discussed on [the GitHub issues page](https://github.com/leeper/tabulapdf/issues) before submitting a pull request. My criteria is to always look for an alternative GitHub link and try to email the package author before retiring it.

Any questions you have can be opened as GitHub issues or directed to hello + r (at) pacha . dev.
