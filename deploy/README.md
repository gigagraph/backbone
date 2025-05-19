# Deploy

This subdirecotry contains code and configuration to deploy various software services to a cloud environment.

## Index

- [`./chat-llm` - Local LLM chat.](./chat-llm/README.md).
- [`./stable-diffusion` - Local Gen AI models that work with images.](./stable-diffusion/README.md).

## Deploy all services

1. Use the template deployment script to create the final deployment script (this repo excludes `deploy/deploy-all.sh` from git):
   ```bash
   cp deploy/deploy-all.example.sh deploy/deploy-all.sh
   ```
2. Edit `deploy/deploy-all.sh` and set the variables according to the instructions in the file.
3. Run the script:
   ```bash
   ./deploy/deploy-all.sh
   ```

## Useful links

- [docker-compose-include][docker-compose-include]

[docker-compose-include]: https://docs.docker.com/compose/how-tos/multiple-compose-files/include/
