FROM denoland/deno:alpine-1.42.0

RUN apk add --no-cache 'git>=2.40'

ENV CODECRAFTERS_DEPENDENCY_FILE_PATHS="deno.json,deno.lock"

WORKDIR /app

COPY package.json ./
COPY app/main.ts ./app/main.ts
RUN deno cache app/main.ts 
RUN rm ./app/main.ts

RUN mkdir -p /app-cached && ls -la /app
# If the node_modules directory exists, move it to /app-cached
RUN if [ -d "/app/node_modules" ]; then mv /app/node_modules /app-cached; fi

RUN printf "cd \${CODECRAFTERS_SUBMISSION_DIR} && deno cache app/main.ts" > /codecrafters-precompile.sh
RUN chmod +x /codecrafters-precompile.sh