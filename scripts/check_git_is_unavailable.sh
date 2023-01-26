#!/bin/bash

tag_name() {
	dockerfile=$1

	local base

	base=$(basename "$dockerfile")
	base=${base%.*}

	echo "git-tester-${base}"
}

ok=0

for f in dockerfiles/*.Dockerfile; do
	tag=$(tag_name "$f")

	docker build -t "$tag" -f "$f" ./dockerfiles

	if docker run --rm -it "$tag" which git; then
		# found git
		ok=1
	else
		# ok
		true
	fi

	docker rmi "$tag"
done

exit "$ok"

