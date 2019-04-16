all: build open

open:
	open public/index.html

build:
	elm make Main.elm --output=public/index.js

deploy: build
	git commit -am "new build"
	git subtree push --prefix public/ origin gh-pages

