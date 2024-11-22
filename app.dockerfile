FROM node:20.18.0-alpine

ARG NEXT_PUBLIC_WS_URL=ws://127.0.0.1:3001
ARG NEXT_PUBLIC_API_URL=http://127.0.0.1:3001/api
ENV NEXT_PUBLIC_WS_URL=${NEXT_PUBLIC_WS_URL}
ENV NEXT_PUBLIC_API_URL=${NEXT_PUBLIC_API_URL}

WORKDIR /home/perplexica

COPY ui /home/perplexica/

# Copy and prepare the initialization script
COPY init_config.sh .
COPY sample.config.toml .
RUN chmod +x init_config.sh
RUN ./init_config.sh

RUN yarn install --frozen-lockfile
RUN yarn build

CMD ["yarn", "start"]
