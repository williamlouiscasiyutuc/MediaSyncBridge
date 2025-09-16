FROM ghcr.io/astral-sh/uv:bookworm-slim AS builder
ENV UV_COMPILE_BYTECODE=0 UV_LINK_MODE=copy UV_PYTHON_INSTALL_DIR=/python UV_PYTHON_PREFERENCE=only-managed
RUN uv python install 3.12

WORKDIR /app
RUN uv venv
RUN --mount=type=cache,target=/root/.cache \
    --mount=type=bind,source=requirements.lock,target=requirements.lock \
    uv pip sync requirements.lock --no-installer-metadata


# Final State
# Distroless is a small image with only python, providing a non-root user
FROM gcr.io/distroless/cc-debian12:nonroot
COPY --from=builder --chown=python:python /python /python

WORKDIR /app
COPY --from=builder --chown=app:app /app/.venv /app/.venv
ENV PATH="/app/.venv/bin:$PATH"
COPY . .

LABEL org.opencontainers.image.authors="MrPandir <MrPandir@users.noreply.github.com>"
LABEL org.opencontainers.image.source="https://github.com/MrPandir/MediaSyncBridge"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.title="MediaSyncBridge"
LABEL org.opencontainers.image.description="A REST API service for parsing and processing links to media content from services like Kinopoisk, IGDB, Shikimori, IMDb, and Steam."

USER nonroot
CMD ["uvicorn", "src.server:app", "--host", "0.0.0.0", "--port", "8000"]
