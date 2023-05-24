createSplash:
	flutter pub run flutter_native_splash:create --path=./flutter_native_splash.yaml

removeSplash:
	flutter pub run flutter_native_splash:remove

build:
	flutter pub run build_runner build

watch:
	flutter pub run build_runner watch

.PHONY: createSplash removeSplash build watch