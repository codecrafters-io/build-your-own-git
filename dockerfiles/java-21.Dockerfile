FROM maven:3.9.5-eclipse-temurin-21-alpine

COPY pom.xml /app/pom.xml

WORKDIR /app

# Download the dependencies
RUN mvn -B package -Ddir=/tmp/codecrafters-git-target

# Cache Dependencies
RUN mkdir -p /app-cached
RUN mv /app/target /app-cached # Is this needed?

# Pre-compile steps
RUN printf "cd \${CODECRAFTERS_REPOSITORY_DIR} && mvn -B package -Ddir=/tmp/codecrafters-git-target && sed -i 's/^\(mvn .*\)/#\1/' ./your_git.sh" > /codecrafters-precompile.sh
RUN chmod +x /codecrafters-precompile.sh