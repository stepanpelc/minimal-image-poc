set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

APP := "demo"
TAG := "poc"
ENGINE := "docker"
TRIVY := "trivy"

JAR_GLOB := "target/*.jar"

IMAGES := "\
{{APP}}:{{TAG}}-distroless \
{{APP}}:{{TAG}}-temurin-alpine \
{{APP}}:{{TAG}}-chainguard-jre \
{{APP}}:{{TAG}}-ubi-micro \
{{APP}}:{{TAG}}-temurin-jammy \
{{APP}}:{{TAG}}-jlink-scratch \
"

default: build-all sizes

java:
	@if [ -x "./mvnw" ]; then \
	  ./mvnw -q -DskipTests package; \
	else \
	  mvn -q -DskipTests package; \
	fi
	@test -n "$$(ls -1 {{JAR_GLOB}} 2>/dev/null | head -n 1)" || (echo "No JAR found in {{JAR_GLOB}}"; exit 1)

build-all: java
	{{ENGINE}} build -f docker/Dockerfile.distroless      -t {{APP}}:{{TAG}}-distroless .
	{{ENGINE}} build -f docker/Dockerfile.temurin-alpine   -t {{APP}}:{{TAG}}-temurin-alpine .
	{{ENGINE}} build -f docker/Dockerfile.chainguard-jre    -t {{APP}}:{{TAG}}-chainguard-jre .
	{{ENGINE}} build -f docker/Dockerfile.ubi-micro         -t {{APP}}:{{TAG}}-ubi-micro .
	{{ENGINE}} build -f docker/Dockerfile.temurin-jammy     -t {{APP}}:{{TAG}}-temurin-jammy .
	{{ENGINE}} build -f docker/Dockerfile.jvm-scratch       -t {{APP}}:{{TAG}}-jlink-scratch .

sizes:
	@printf "%-45s %-10s\n" "IMAGE" "SIZE"
	@printf "%-45s %-10s\n" "-----" "----"
	@{{ENGINE}} images \
	  --format '{{"{{"}}.Repository{{"}}"}}:{{"{{"}}.Tag{{"}}"}} {{ "{{"}}.Size{{"}}" }}' \
	  | grep '^{{APP}}:{{TAG}}-' \
	  | sort


scan image:
	echo "Scanning {{image}}"; \
	echo "-----------------------------"; \
	TRIVY_IMAGE_SOURCE={{ENGINE}} {{TRIVY}} image --quiet --severity CRITICAL,HIGH --ignore-unfixed {{image}}; 

scan-all:
	just scan {{APP}}:{{TAG}}-distroless
	just scan {{APP}}:{{TAG}}-temurin-alpine
	just scan {{APP}}:{{TAG}}-chainguard-jre
	just scan {{APP}}:{{TAG}}-ubi-micro
	just scan {{APP}}:{{TAG}}-temurin-jammy
	just scan {{APP}}:{{TAG}}-jlink-scratch

clean-images:
	@{{ENGINE}} images --format '{{"{{"}}.Repository{{"}}"}}:{{"{{"}}.Tag{{"}}"}}' \
	  | grep '^{{APP}}:{{TAG}}-' \
	  | xargs -r {{ENGINE}} rmi -f

clean-java:
	@if [ -x "./mvnw" ]; then \
	  ./mvnw -q clean; \
	else \
	  mvn -q clean; \
	fi

clean: clean-java clean-images
