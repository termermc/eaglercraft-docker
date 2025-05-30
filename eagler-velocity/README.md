# eagler-velocity

Creates a Velocity server preconfigured with Eaglercraft plugins in Docker.

## Setup

Run `./build.sh` to build the container. Will also compile the necessary Eaglercraft plugins from source.

Run `./hostinit.sh`. This will create necessary files on the host.

Edit velocity.toml as needed.
By default, it is configured to connect to a single backend server at `127.0.0.1:30066`.
It is also tuned for performance on Linux. If you want to run on another operating system, consult the file's comments and disable options that require Linux.

Run `docker compose up -d` to start the server.

---

The above steps should be done manually the first time, but subsequent runs can be condensed to just `./build.sh && ./hostinit.sh && docker compose up -d`.
