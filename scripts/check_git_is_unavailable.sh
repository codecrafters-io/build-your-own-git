#!/bin/bash

tag_name() {
	dockerfile=$1

	local base

	base=$(basename "$dockerfile")
	base=${base%.*}

	echo "git-tester-${base}"
}

in_image() {
	local tag="$1"
	shift

	docker run --rm "$tag" "$@"
}

ok=0

for f in dockerfiles/*.Dockerfile; do
	tag=$(tag_name "$f")

	docker build -t "$tag" -f "$f" ./dockerfiles

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

