FROM denoland/deno:alpine-1.42.0

RUN apk add --no-cache 'git>=2.40'

ENV CODECRAFTERS_DEPENDENCY_FILE_PATHS="deno.json,deno.lock"

WORKDIR /app

COPY deno.json deno.lock ./

RUN printf "cd \${CODECRAFTERS_SUBMISSION_DIR} && deno cache app/main.ts" > /codecrafters-precompile.sh
RUN chmod +x /codecrafters-precompile.sh