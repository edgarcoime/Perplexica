FROM node:18-slim

WORKDIR /home/perplexica

COPY src /home/perplexica/src
COPY tsconfig.json /home/perplexica/
COPY drizzle.config.ts /home/perplexica/
COPY package.json /home/perplexica/
COPY yarn.lock /home/perplexica/

# Copy and prepare the initialization script
COPY init_config.sh /home/perplexica/
COPY sample.config.toml /home/perplexica/
RUN chmod +x /home/perplexica/init_config.sh
RUN /bin/bash /home/perplexica/init_config.sh

RUN ls -ltr /home/perplexica|cat>"Directorylisting.txt"

RUN mkdir /home/perplexica/data

RUN yarn install --frozen-lockfile --network-timeout 600000
RUN yarn build

CMD ["yarn", "start"]
