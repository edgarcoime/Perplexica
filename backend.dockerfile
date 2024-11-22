FROM node:18-slim

WORKDIR /home/perplexica

COPY src /home/perplexica/src
COPY tsconfig.json /home/perplexica/
COPY drizzle.config.ts /home/perplexica/
COPY package.json /home/perplexica/
COPY yarn.lock /home/perplexica/

# Copy and prepare the initialization script
COPY init_config.sh .
COPY sample.config.toml .
RUN chmod +x init_config.sh
RUN ./init_config.sh

RUN mkdir /home/perplexica/data

RUN yarn install --frozen-lockfile --network-timeout 600000
RUN yarn build

CMD ["yarn", "start"]
