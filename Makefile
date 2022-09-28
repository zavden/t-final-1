ej=01
SHELL=/bin/bash
BUILD=go run
mk=go
t=P-0$(ej)
p=c$(ej)/main.go

N_NEXT=1
EXERCISES_LS=$(shell ls -1 src/ejercicios | wc -l)
NEXT_EXERCISE=$$(( $(EXERCISES_LS)  + $(N_NEXT)   ))
NEXT_EXERCISE_FORMAT=$(shell echo $$(($(NEXT_EXERCISE))))

EXAMPLES_LS=$(shell ls -1 src/ejemplos | wc -l)
NEXT_EXAMPLE=$$(( $(EXAMPLES_LS)  + $(N_NEXT)   ))
NEXT_EXAMPLE_FORMAT=$(shell printf "%02.f" $(NEXT_EXAMPLE))

MARKDOWN_LS=$(shell ls -1 src/markdown/*.md | wc -l)
NEXT_MARKDOWN=$$(( $(MARKDOWN_LS)  + $(N_NEXT)   ))
NEXT_MARKDOWN_FORMAT=$(shell printf "%02.f" $(NEXT_MARKDOWN))

init:
	npx pug -wP src/ -o docs/ -b ./ &
	npx sass --watch src/:docs/ &
	npx tsc -w &
	npx live-server docs/

static: copy-static init

clean:
	rm -rf docs/
	cp -r ./modules/docs-static ./docs
	mkdir -p docs/ejercicios/ docs/markdown/
	if [ -z `ls -A src/markdown/*.html` ]; then echo "Markdown empty so NO copy"; else cp src/markdown/*.html docs/markdown; fi

build: clean copy-static init

clean-all:
	rm -rf node_modules modules package* tsconfig.json docs templates

copy-static:
	watchexec -w src/static 'cp -r src/static docs/' &

copy-md:
	cp src/markdown/*.html docs/markdown


git-init:
	git init
	git add .
	git commit -m "First commit"

new-e:
	cp templates/ejercicios.pug src/ejercicios/
	mv src/ejercicios/ejercicios.pug src/ejercicios/ejercicios-$(ej).pug

new-h:
	mkdir -p src/ejemplos/ej-$(ej)
	cp templates/ejemplo/* src/ejemplos/ej-$(ej)

new-md:
	cp templates/markdown/md.md src/markdown/md-$(ej).md

rg:
	rm -rf .git

del:
	rm -rf $(titulo)

next-e:
	@echo $(NEXT_EXERCISE_FORMAT)
	sed 's/NL/$(NEXT_EXERCISE_FORMAT)/g' templates/ejercicios.pug > src/ejercicios/ejercicios-0$(NEXT_EXERCISE_FORMAT).pug
	sed 's/NE/$(NEXT_EXERCISE_FORMAT)/' templates/functions.pug > modules/pug/functions/functions.pug

next-h:
	@echo $(NEXT_EXAMPLE_FORMAT)
	mkdir -p src/ejemplos/ej-$(NEXT_EXAMPLE_FORMAT)
	cp templates/ejemplo/* src/ejemplos/ej-$(NEXT_EXAMPLE_FORMAT)

next-md:
	cp templates/markdown/md.md src/markdown/md-$(NEXT_MARKDOWN_FORMAT).md
