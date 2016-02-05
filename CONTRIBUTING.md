Thanks for your contribution!

## Edit the task view:

### Requirements:

* R
* `make`
* [`pandoc`](http://johnmacfarlane.net/pandoc/installing.html)

If you don't want to or can't install these things, then just edit the `webtech.md` file, and submit a pull request.

### Steps

1. Fork this repo
2. Edit the [webtech.md](https://github.com/ropensci/webservices/blob/master/webtech.md) file. If the package you are adding is on CRAN, add a the package name within `<pkg></pkg>` tags (use `<ohat></ohat>` for OmegaHat packages, `<rforge></rforge>` for [RForge](https://r-forge.r-project.org/), and `<bioc></bioc>` for [Bioconductor](http://www.bioconductor.org/) packages). If it's not on CRAN, put it markdown link syntax: `[display-text](url)` (e.g., `[rgbif](https://github.com/ropensci/rgbif) (not on CRAN)`). If there is a non-CRAN source repository available, add it as a link in parentheses after the package name (e.g., `<pkg>rgbif</pkg> ([GitHub](https://github.com/ropensci/rgbif))`). Note that GitHub is written in camel case.
3. On the command line type `make` and press enter, which creates the `WebTechnologies.ctv`, `WebTechnologies.html`, and `README.md` files.
4. Check to make sure the `.ctv` file is correct. In the console output from `make check`, you should get:

    ```coffee
    $`Packages in <info> but not in <packagelist>`
    character(0)

    $`Packages in <packagelist> but not in <info>`
    character(0)

    $`Packages in <packagelist> but not in repos`
    character(0)
    ```

    If you don't, follow the error messages to fix. If you can't figure out how to fix, just send the PR anyway, and the maintainer will fix.

    If you changed anything in the `webtech.md` file, repeat step 3 to remake files. If everything was fine, proceed.
5. Push back up to your account, then send a pull request to `ropensci/webservices`

## Submit an issue

If you just want to submit an issue, then go to the [issues page](https://github.com/ropensci/webservices/issues?state=open) and do that. Please list as much of the following as possible: package name, repository, development URL, description/details.
