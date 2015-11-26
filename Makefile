all: buildxml ctv2html readme

buildxml:
	pandoc -w html -o WebTechnologies.ctv webtech.md
	Rscript --vanilla -e 'source("buildxml.R")'

checkctv:
	Rscript --vanilla -e 'if(!require("ctv")) install.packages("ctv", repos = "http://cran.rstudio.com/"); print(ctv::check_ctv_packages("WebTechnologies.ctv"))'

ctv2html:
	Rscript --vanilla -e 'if(!require("ctv")) install.packages("ctv", repos = "http://cran.rstudio.com/"); ctv::ctv2html("WebTechnologies.ctv")'

readme:
	pandoc -w markdown_github -o README.md WebTechnologies.html
	sed -i.tmp -e 's|( \[|(\[|g' README.md
	sed -i.tmp -e 's| : |: |g' README.md
	sed -i.tmp -e 's|../packages/|http://cran.rstudio.com/web/packages/|g' README.md
	sed -i.tmp -e 's/^[|]-/*Do not edit this README by hand. See \[CONTRIBUTING.md\]\(CONTRIBUTING.md\).*\n\n|||\n|-/g' README.md
	rm *.tmp

md2html:
	pandoc -o README.html README.md
