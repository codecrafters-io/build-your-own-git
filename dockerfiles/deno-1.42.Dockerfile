FROM denoland/deno:alpine-1.42.0

RUN apk add --no-cache 'git>=2.40'

ENV CODECRAFTERS_DEPENDENCY_FILE_PATHS="package.json"

WORKDIR /app

COPY package.json ./
# If users import dependencies in files foo.ts and bar.ts, unless those files are present while running deno cache, these dependencies will not be resolved. 
# Even if they are present in package.json#dependencies.
COPY app/ ./app/
RUN deno cache app/main.ts 
RUN rm -rf ./app/

RUN mkdir -p /app-cached
# If the node_modules directory exists, move it to /app-cached
RUN if [ -d "/app/node_modules" ]; then mv /app/node_modules /app-cached; fi

RUN printf "cd \${CODECRAFTERS_SUBMISSION_DIR} && deno cache app/main.ts" > /codecrafters-precompile.sh
RUN chmod +x /codecrafters-precompile.sh