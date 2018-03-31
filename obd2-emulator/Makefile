.PHONY: prepare clean build upload
default: build

prepare:
	mkdir -p .build

clean: prepare
	rm -rf .build/*

build: clean
	/opt/arduino-1.8.5/arduino --verify src/sketch.ino

upload: clean
	/opt/arduino-1.8.5/arduino --upload src/sketch.ino


