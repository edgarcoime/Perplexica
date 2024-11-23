FROM node:18-slim

# Declare the build argument
# if only need during buildtime
ARG OPENAI 
ARG GROQ 
ARG ANTHROPIC 

# Optional: Set as an environment variable for the build stage if needed
# This persists arg into runtime env
ENV OPENAI=${OPENAI}
ENV GROQ=${GROQ}
ENV ANTHROPIC=${ANTHROPIC}

WORKDIR /home/perplexica

COPY src /home/perplexica/src
COPY tsconfig.json /home/perplexica/
COPY drizzle.config.ts /home/perplexica/
COPY package.json /home/perplexica/
COPY yarn.lock /home/perplexica/

RUN mkdir /home/perplexica/data

# Copy and prepare the initialization script
COPY sample.config.toml /home/perplexica/
COPY init_config.sh /home/perplexica/
RUN chmod +x /home/perplexica/init_config.sh
RUN /bin/bash /home/perplexica/init_config.sh

RUN yarn install --frozen-lockfile --network-timeout 600000
RUN yarn build

# If you want env vars from docker-compose needs to be 
# in entry point. Docker caches previous calls so not possible there
# https://stackoverflow.com/questions/55921914/how-to-source-a-script-with-environment-variables-in-a-docker-build-process
# ENTRYPOINT ["/home/perplexica/init_config.sh"]
CMD ["yarn", "start"]
