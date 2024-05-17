FROM swift:5.10

ENV CODECRAFTERS_DEPENDENCY_FILE_PATHS="Package.swift"

COPY Package.swift /app/Package.swift
RUN mkdir -p /app/Sources
RUN echo "print(\"Hello, world!\")" > /app/Sources/main.swift

WORKDIR /app
RUN swift build

RUN echo "cd \${CODECRAFTERS_SUBMISSION_DIR} && swift build" > /codecrafters-precompile.sh
RUN chmod +x /codecrafters-precompile.sh
