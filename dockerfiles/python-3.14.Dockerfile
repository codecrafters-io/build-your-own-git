# syntax=docker/dockerfile:1.7-labs
FROM astral/uv:python3.14-alpine

# Ensures the container is re-built if dependency files change
ENV CODECRAFTERS_DEPENDENCY_FILE_PATHS="pyproject.toml,uv.lock"

# Prevents Python from buffering stdout and stderr
ENV PYTHONUNBUFFERED=1

ENV PYTHONPATH=/app:$PYTHONPATH

WORKDIR /app

# .git & README.md are unique per-repository. We ignore them on first copy to prevent cache misses
COPY --exclude=.git --exclude=README.md . /app

# Force environment creation
RUN uv sync