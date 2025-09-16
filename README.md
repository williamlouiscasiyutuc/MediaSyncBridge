# MediaSyncBridge

A REST API service for parsing and processing links to media content from services like Kinopoisk, IGDB, Shikimori, IMDb, and Steam.

## Installation

> [!IMPORTANT]
>
> This project requires [Python](https://www.python.org/) 3.12 or higher.
>
> It uses [Rye](https://rye-up.com/) for dependency management.

1. Clone the repository
   ```
   git clone https://github.com/MrPandir/MediaSyncBridge.git
   cd MediaSyncBridge
   ```

2. Install dependencies
   ```bash
   rye sync
   ```

3. Copy the example configuration file and fill it in
   ```bash
   cp .env.example .env
   ```
   Fill in the values in `.env` [(details below)](#configuration).

4. Run the server
   - For development (with reload enabled, available at [http://localhost:80](http://localhost:80))
     ```bash
     rye run dev
     ```
   - For production
     ```bash
     python -m src.server
     ```
     or
     ```bash
     uvicorn src.server:app --host 0.0.0.0 --port 8000
     ```

## Configuration

To work with external APIs, environment variables need to be configured. Use the `.env` file based on the example `.env.example`.

```
# Client credentials for IGDB (obtain at https://dev.twitch.tv/console)
IGDB_CLIENT_ID=
IGDB_CLIENT_SECRET=

# API key for Kinopoisk (obtain at https://kinopoiskapiunofficial.tech)
KINOPOISK_API_KEY=
```

These keys are required for authenticating requests to IGDB and Kinopoisk. The other services (IMDb, Steam) utilize these two APIs. Shikimori does not require authorization.

## Usage

### Endpoint

- **Method**: GET
- **Path**: `/get`
- **Parameters**:
  - `url` (string, required): Link to media content from a supported service.

### Example Request

```
GET http://localhost:8000/get?url=https://www.kinopoisk.ru/film/123456/
```

### Example Successful Response

```json
{
  "ids": {
    "IMDb": "tt0061155",
    "Kinopoisk": "123456"
  },
  "clean_url": "https://kinopoisk.ru/film/123456",
  "service": "kinopoisk"
}
```

### Example Error Response

```json
{
  "error": "Unsupported link",
  "link": "https://www.kinopoisk.ru/film/"
}
```

API documentation is available at `/docs` (Swagger UI) after starting the server.

## Docker

The project is packaged as a Docker image for easy deployment.

1. Build the image locally
   ```
   docker build -t MediaSyncBridge .
   ```

2. Or pull from Docker Hub
   ```
   docker pull MrPandir/MediaSyncBridge:latest
   ```

3. Run the container, passing environment variables
   ```
   docker run -d -p 8000:8000 \
     --env-file .env \
     MrPandir/MediaSyncBridge
   ```

The service will be available at [http://localhost:8000](http://localhost:8000).
