.PHONY: check

check:
	python3 scripts/check_repository.py

.PHONY: test
test:
	docker build --platform linux/amd64 -f docker/Dockerfile -t localization-tests .
	docker run --rm --platform linux/amd64 --network none -v "$(CURDIR):/project:ro" localization-tests octave --no-gui --quiet tests/test_solvers.m
