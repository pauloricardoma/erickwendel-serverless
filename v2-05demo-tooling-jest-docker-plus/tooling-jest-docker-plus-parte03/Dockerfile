FROM node:16-slim 

WORKDIR /src

COPY package.json package-lock.json  /src/

RUN npm ci --silent

COPY . .

USER node

CMD npm run start --prefix ./