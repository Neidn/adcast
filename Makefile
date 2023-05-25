createSplash:
	dart run flutter_native_splash:create --path=./flutter_native_splash.yaml

removeSplash:
	dart run flutter_native_splash:remove

build:
	dart run build_runner build

watch:
	dart run build_runner watch

.PHONY: createSplash removeSplash build watch