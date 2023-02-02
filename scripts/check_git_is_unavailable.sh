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

	docker build -q -t "$tag" -f "$f" "./starter_templates/$lang/" >/dev/null

	if in_image "$tag" which sh >/dev/null && ! in_image "$tag" which git; then
		# ok
		echo "ok   $f"
	else
		# found git or something failed in general
		ok=1

		echo "fail $f"
	fi

	docker rmi "$tag" >/dev/null
done

if test "$ok" -eq 0; then
	echo OK
else
	echo FAIL

	exit "$ok"
fi

