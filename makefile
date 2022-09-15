.PHONY: all clean

all: build/GetBib.Rc

build/GetBib.Rc: src/GetBib.R
	Rscript -e 'compiler::cmpfile("src/GetBib.R", "build/GetBib.Rc")'

clean:
	rm -rf build/GetBib.Rc