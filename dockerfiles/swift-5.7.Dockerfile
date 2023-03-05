FROM swift:5.7.3-focal

RUN apt update && \
	apt install --no-install-recommends --yes git && \
	rm -r /var/lib/apt/lists/
