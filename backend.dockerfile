FROM node:18-slim

WORKDIR /home/perplexica

COPY src /home/perplexica/src
COPY tsconfig.json /home/perplexica/
COPY drizzle.config.ts /home/perplexica/
COPY package.json /home/perplexica/
COPY yarn.lock /home/perplexica/

RUN mkdir /home/perplexica/data

RUN yarn install --frozen-lockfile --network-timeout 600000
RUN yarn build

# Copy and prepare the initialization script
COPY init_config.sh /home/perplexica/
COPY sample.config.toml /home/perplexica/
RUN chmod +x /home/perplexica/init_config.sh

# If you want env vars from docker-compose needs to be 
# in entry point. Docker caches previous calls so not possible there
# https://stackoverflow.com/questions/55921914/how-to-source-a-script-with-environment-variables-in-a-docker-build-process
ENTRYPOINT ["/home/perplexica/init_config.sh"]
CMD ["yarn", "start"]
