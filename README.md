# Comet

> Music on ATProto.

Comet's goal is to provide an open, decentralised alternative for uploading and
sharing your music with others.

Follow on Bluesky: [@comet.sh](https://bsky.app/profile/comet.sh) /
[@ovyerus.com](https://bsky.app/profile/ovyerus.com)  
Or chat along on our Discord: https://discord.gg/ZKK7DnubD9

This project is in the _very_ early stages and a lot will change over time,
especially as this is my first foray into the ATProtocol ecosystem. Stuff will
be a bit messy for a while. Feel free to contribute and voice your opinions!

## Current Status

- [ ] Experimental Lexicons
  - [x] Records
  - [ ] Queries
- [ ] AppView (Elixir)
- [ ] Clients

---

## Development Setup

**Important:** You must have PostgreSQL and Tap running in the Docker Compose
before running `mix setup`, or the setup will fail.

Start the required services:

```sh
docker compose up -d
```

You can get started with Comet using either Nix (recommended) or by installing
dependencies manually.

### Using Nix (Recommended)

1. Install [Nix](https://nixos.org/download.html) if you don't have it.

2. Enter the development shell:
  ```sh
  nix develop
  ```
  This will provide Elixir, Erlang, Node.js, pnpm, Tailwind CSS, and other tools.

3. Install JS dependencies:
  ```sh
  pnpm install
  ```

4. Set up the database (with Docker Compose running):
  ```sh
  mix setup
  ```

5. Start the Phoenix server:
  ```sh
  mix phx.server
  ```

6. Visit [http://localhost:4000](http://localhost:4000) in your browser.

### Manual Setup

1. Install [Elixir](https://elixir-lang.org/install.html) (~> 1.15),
[Erlang/OTP](https://www.erlang.org/downloads), [Node.js](https://nodejs.org/),
and [pnpm](https://pnpm.io/).

2. Install JS dependencies:
  ```sh
  pnpm install
  ```

3. Set up the database (with Docker Compose running):
  ```sh
  mix setup
  ```

4. Start the Phoenix server:
  ```sh
  mix phx.server
  ```

5. Visit [http://localhost:4000](http://localhost:4000) in your browser.
