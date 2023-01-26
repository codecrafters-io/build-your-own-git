#!/bin/bash

set -eu

tag_name() {
	dockerfile=$1

	local base
	base=$(basename "$dockerfile" .Dockerfile)

	echo "git-tester-${base}"
}

lang_slug() {
	dockerfile=$1

	local base
	base=$(basename "$dockerfile" .Dockerfile)

	echo "$base" | cut -d- -f1
}

in_image() {
	local tag="$1"
	shift

	docker run --rm "$tag" "$@"
}

ok=0

for f in dockerfiles/*.Dockerfile; do
	lang=$(lang_slug "$f")
	tag=$(tag_name "$f")

	docker build -t "$tag" -f "$f" "./starter_templates/$lang/"

	if in_image "$tag" which sh && ! in_image "$tag" which git; then
		# ok
		true
	else
		# found git or something failed in general
		ok=1
	fi

	docker rmi "$tag"
done

exit "$ok"

