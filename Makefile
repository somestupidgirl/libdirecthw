prefix ?= /usr/local

all: main libs

main:
	xcodebuild -alltargets

libs: DirectHW.c DirectHW.h
	$(CC) DirectHW.c -dynamiclib -framework IOKit -o libDirectHW.dylib
	$(CC) -static -c DirectHW.c -o libDirectHW.a
	mv libDirectHW.dylib build/Release/libDirectHW.dylib
	mv libDirectHW.a build/Release/libDirectHW.a

install:
	cp build/Release/usr/local/include/DirectHW.h $(prefix)/include/DirectHW.h

	cp build/Release/libDirectHW.a $(prefix)/lib/libDirectHW.a
	chmod 644 $(prefix)/lib/libDirectHW.a

	cp build/Release/libDirectHW.dylib $(prefix)/lib/libDirectHW.dylib
	chmod 644 $(prefix)/lib/libDirectHW.dylib

	cp -r build/Release/DirectHW.framework $(prefix)/Frameworks/DirectHW.framework
	chmod -R 755 $(prefix)/Frameworks/DirectHW.framework

clean:
	rm -rf build
