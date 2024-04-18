FROM denoland/deno:alpine-1.42.0

RUN apk add --no-cache 'git>=2.40'

RUN echo "cd \${CODECRAFTERS_SUBMISSION_DIR} && deno cache app/main.ts && sed -i 's/^\(deno cache .*\)/#\1/' ./your_git.sh" > /codecrafters-precompile.sh
RUN chmod +x /codecrafters-precompile.sh