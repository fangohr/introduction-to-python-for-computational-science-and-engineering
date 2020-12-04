all:
	make html
	make pdf


docker-all:
	make docker-build
	make docker-html
	make docker-pdf
	make docker-nbval


install:
	poetry -vvv install

clean:
	cd book; rm -rf \
		*.aux *.out *.log pylabimshow* myplot* myfile* \
		combined_files hello.txt hello.py data.mat test.txt vectools.py \
		module1.py pylabhistogram.pdf eu-pop-2017.csv

html:
	poetry run jupyter-book build book --builder html

pdf: book/*-*.ipynb
	poetry run jupyter-book build book --builder pdflatex

nbval:
	make clean
	poetry run pytest -v --nbval book/*.ipynb --sanitize-with book/static/nbval_sanitize.cfg

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

# to update the title page:
# - screenshot first page of pdf
# - (edit out date if desired)
# - add border around bitmap, for example using
#   "convert titlepage.png -shave 1x1 -bordercolor black -border 1 titlepage-with-border.png"
