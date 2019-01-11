RSCRIPT = Rscript --no-init-file

all: README.md

WebTechnologies.ctv: webtech.md buildxml.R
	pandoc -w html --wrap=none -o WebTechnologies.ctv webtech.md
	${RSCRIPT} -e 'source("buildxml.R")'

WebTechnologies.html: WebTechnologies.ctv
	${RSCRIPT} -e 'if(!require("ctv")) install.packages("ctv", repos = "https://cran.rstudio.com/"); ctv::ctv2html("WebTechnologies.ctv")'

README.md: WebTechnologies.html
	pandoc -w gfm --wrap=none -o README.md WebTechnologies.html
	sed -i.tmp -e 's|( \[|(\[|g' README.md
	sed -i.tmp -e 's| : |: |g' README.md
	sed -i.tmp -e 's|../packages/|https://cran.rstudio.com/web/packages/|g' README.md
	# sed -i.tmp -e '4s/.*/| | |\n|---|---|/' README.md
	# sed -i.tmp -e '4i*Do not edit this README by hand. See \[CONTRIBUTING.md\]\(CONTRIBUTING.md\).*\n' README.md
	rm *.tmp

check:
	${RSCRIPT} -e 'if(!require("ctv")) install.packages("ctv", repos = "http://cran.rstudio.com/"); print(ctv::check_ctv_packages("WebTechnologies.ctv", repos = "https://cran.rstudio.com/"))'

checkurls:
	${RSCRIPT} -e 'source("checkurls.R")'

checkgithub:
	${RSCRIPT} -e 'source("check_github_on_cran.R")'

README.html: README.md
	pandoc --from=gfm -o README.html README.md

diff:
	git pull
	svn checkout svn://svn.r-forge.r-project.org/svnroot/ctv/pkg/inst/ctv
	cp ./ctv/WebTechnologies.ctv WebTechnologies.ctv
	git diff WebTechnologies.ctv > cran.diff
	git checkout -- WebTechnologies.ctv
	rm -r ./ctv

svn:
	svn checkout svn+ssh://schamber789@svn.r-forge.r-project.org/svnroot/ctv/
	cp WebTechnologies.ctv ./ctv/pkg/inst/ctv/
	cd ./ctv
	svn status

release:
	cd ./ctv
	svn commit --message "update WebTechnologies"
	cd ../
	rm -r ./ctv
