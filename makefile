.PHONY: all clean dag

all: build/GetBib.Rc

dag: makefile-dag.png

build: 
	mkdir -p build

build/GetBib.Rc: src/GetBib.R build
	Rscript -e 'compiler::cmpfile("src/GetBib.R", "build/GetBib.Rc")'

clean:
	rm -rf build

makefile-dag.png: makefile
	make -Bnd | make2graph | dot -Tpng -Gdpi=200 -o makefile-dag.png
	convert makefile-dag.png -gravity center -background white makefile-dag.png