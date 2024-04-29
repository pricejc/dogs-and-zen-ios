.PHONY: fmt

fmt:
	swift-format -p -i -r .

lint:
	swift-format lint -p -s -r .
