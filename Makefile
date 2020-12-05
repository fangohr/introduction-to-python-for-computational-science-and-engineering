all:
	make html
	make pdf

install:
	poetry -vvv install

clean:
	cd book; rm -rf \
		*.aux *.out *.log pylabimshow* myplot* myfile* \
		combined_files hello.txt hello.py data.mat test.txt vectools.py \
		module1.py pylabhistogram.pdf eu-pop-2017.csv \
		_build .ipynb_checkpoints

html:
	poetry run jupyter-book build book --builder html

pdf: book/*-*.ipynb
	poetry run jupyter-book build book --builder pdflatex

nbval:
	poetry run pytest -v --nbval book/*.ipynb --sanitize-with book/static/nbval_sanitize.cfg


docker-all:
	make clean
	make docker-build
	make docker-html
	make docker-pdf
	make docker-nbval

docker-build:
	docker build -t python4compscience .

# Occasionally (after changing branch) we need to force rebuild:
docker-build-nocache:
	docker build -t python4compscience2 --no-cache .

# build pdf and html through container
docker-html:
	docker run -v `pwd`:/io python4compscience make html

docker-pdf:
	docker run -v `pwd`:/io python4compscience make pdf

docker-nbval:
	docker run -v `pwd`:/io python4compscience make nbval

# to update the title page:
# - screenshot first page of pdf
# - (edit out date if desired)
# - add border around bitmap, for example using
#   "convert titlepage.png -shave 1x1 -bordercolor black -border 1 titlepage-with-border.png"
