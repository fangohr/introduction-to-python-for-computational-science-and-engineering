all:
	make check-py35
	make notebooks-html
	make notebooks-pdf

docker-all:
	make docker-build
	make docker-check-py35
	make docker-check-pandas
	make docker-html
	make docker-pdf
	make docker-nbval


notebooks-pdf: *-*.ipynb static/latex_template.tplx
	@echo "Attempting to create combined.pdf from notebooks"
	python3 -m bookbook.latex --pdf --template static/latex_template.tplx
	@mkdir -p pdf
	mv -v combined.pdf pdf/Introduction-to-Python-for-Computational-Science-and-Engineering.pdf
	make version && mv -v version.txt pdf

notebooks-html: check-py35
	@echo "Attempting to create html version (in ./html)"
	python3 -m bookbook.html
	@echo "Output stored in html/*html; start with html/index.html"
	make version && mv -v version.txt html
	@echo "Move files to 'docs' (for github pages)"
	mkdir -p docs
	mv html/*.html html/version.txt docs
	@echo "If this version should be hosted on github, you need to 'cd docs && git commit .' or similar."

check-py35:
	@echo "Checking Python version is >= 3.5"
	@python3 -c "import sys; assert sys.version_info[0] >= 3"
	@python3 -c "import sys; assert sys.version_info[1] >= 5"
	@echo "        (ok)"

check-pandas:
	@echo "which python"
	@which python3
	@python3 -c "import pandas; print(pandas.__version__)"

version:
	echo "Last compiled: `date`" > version.txt
	echo " " >> version.txt
	echo "Last commit:" >> version.txt
	git log HEAD -1	 >> version.txt

nbval:
	py.test -v --nbval --sanitize-with static/nbval_sanitize.cfg *.ipynb

clean:
	rm -rf *.aux *.out *.log combined_files hello.txt hello.py pylabimshow* myplot* myfile* data.mat test.txt vectools.py module1.py pylabhistogram.pdf


# To use Docker container for building and testing

# build docker image locally, needs to be done first
docker-build:
	docker build -t python4compscience -f tools/docker/Dockerfile .

# Occasionally (after changing branch) we need to force rebuild:
docker-build-nocache:
	docker build -t python4compscience2 --no-cache -f tools/docker/Dockerfile .

# build pdf and html through container
docker-html:
	docker run -v `pwd`:/io python4compscience make notebooks-html

docker-pdf:
	docker run -v `pwd`:/io python4compscience make notebooks-pdf

docker-nbval:
	docker run -v `pwd`:/io python4compscience make nbval

docker-check-py35:
	docker run -v `pwd`:/io python4compscience make check-py35

docker-check-pandas:
	docker run -v `pwd`:/io python4compscience make check-pandas


# to update the title page:
# - screenshot first page of pdf
# - (edit out date if desired)
# - add border around bitmap, for example using
#   "convert titlepage.png -shave 1x1 -bordercolor black -border 1 titlepage-with-border.png"
