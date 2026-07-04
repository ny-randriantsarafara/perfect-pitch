.PHONY: setup analyze test ci build-web build-ios deploy-testflight sync-signing help

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-22s\033[0m %s\n", $$1, $$2}'

setup: ## Install Flutter deps, iOS pods, and Fastlane gems
	flutter pub get
	bundle install
	cd ios && bundle exec pod install

analyze: ## Run Flutter static analysis
	flutter analyze

test: ## Run Flutter tests
	flutter test

ci: analyze test build-web ## Run the full CI validation suite

build-web: ## Build Flutter web release
	flutter build web --release

build-ios: ## Build iOS IPA via Fastlane
	bundle exec fastlane ios build_ios

deploy-testflight: ## Build and upload iOS to TestFlight
	bundle exec fastlane ios testflight_upload

sync-signing: ## Sync iOS signing certificates via Match
	bundle exec fastlane ios sync_signing
