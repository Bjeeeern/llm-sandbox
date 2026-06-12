# llm-sandbox

A small Docker sandbox for running [opencode](https://opencode.ai/) against a local workspace.

## What It Does

Starts two containers:

- `opencode`: runs opencode with your project mounted at `/workspace`
- `openai-proxy`: injects your `OPENAI_API_KEY` into allowed OpenAI requests

The opencode config points at the proxy instead of storing the real API key directly:

```json
{
  "provider": {
    "openai": {
      "options": {
        "baseURL": "http://openai-proxy:8080/v1",
        "apiKey": "unused-proxy-injects-real-key"
      }
    }
  }
}
```

The proxy currently allows:
- /v1/responses
- /v1/models

## Security Model

The agent can read and write the mounted workspace. If you mount sensitive files, assume the agent can read them.

The OpenAI API key is kept out of opencode.json and injected by the proxy at request time.
