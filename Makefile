all: README.md

WebTechnologies.ctv: webtech.md buildxml.R
	pandoc -w html -o WebTechnologies.ctv webtech.md
	Rscript --vanilla -e 'source("buildxml.R")'

WebTechnologies.html: WebTechnologies.ctv
	Rscript --vanilla -e 'if(!require("ctv")) install.packages("ctv", repos = "http://cran.rstudio.com/"); ctv::ctv2html("WebTechnologies.ctv")'

README.md: WebTechnologies.html
	pandoc -w markdown_github -o README.md WebTechnologies.html
	sed -i.tmp -e 's|( \[|(\[|g' README.md
	sed -i.tmp -e 's| : |: |g' README.md
	sed -i.tmp -e 's|../packages/|http://cran.rstudio.com/web/packages/|g' README.md
	sed -i.tmp -e 's/||/| | |\n| -- | -- |/g' README.md
	sed -i.tmp -e '4i*Do not edit this README by hand. See \[CONTRIBUTING.md\]\(CONTRIBUTING.md\).*\n' README.md
	rm *.tmp

check:
	Rscript --vanilla -e 'if(!require("ctv")) install.packages("ctv", repos = "http://cran.rstudio.com/"); print(ctv::check_ctv_packages("WebTechnologies.ctv", repos = "http://cran.rstudio.com/"))'

README.html: README.md
	pandoc -o README.html README.md

svn:
	svn checkout svn+ssh://thomasleeper@svn.r-forge.r-project.org/svnroot/ctv/
	cp WebTechnologies.ctv ./ctv/pkg/inst/ctv/
	cd ./ctv
	svn status

release:
	cd ./ctv
	svn commit --message "update WebTechnologies"
	cd ../
