FROM zenika/kotlin:1.4.20-jdk11-slim

RUN apt update && \
	apt install --no-install-recommends --yes git && \
	rm -r /var/lib/apt/lists/
