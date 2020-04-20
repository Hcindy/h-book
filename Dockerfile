# online yarn, about 231MB
# 1. docker build -t gitbook:online .
# 2. docker run -d -p 40000:4000 --name gitbook gitbook:online
# FROM node:12-alpine

# RUN mkdir /root/books \
#     && yarn config set registry https://registry.npm.taobao.org/ \
#     && yarn global add gitbook-cli@2.3.2 \
#     && gitbook fetch 3.2.2 \
#     && yarn cache clean \
#     && npm cache clean --force \
#     && rm -rf /tmp/*

# ADD hbook/ /root/books

# CMD ["gitbook", "serve", "/root/books"]

# online npm, about 209MB
# 1. docker build -t gitbook:npm .
# 2. docker run -d -p 40000:4000 --name gitbook gitbook:npm
# FROM node:12-alpine

# RUN mkdir /root/books \
#     && npm config set registry https://registry.npm.taobao.org/ \
#     && npm install -g gitbook-cli@2.3.2 \
#     && gitbook fetch 3.2.2 \
#     && npm cache clean --force \
#     && rm -rf /tmp/*

# ADD hbook/ /root/books

# CMD ["gitbook", "serve", "/root/books"]

# offline, about 169MB
# 0. docker cp gitbook:/usr/local/lib/node_modules/gitbook-cli ./offline/npm/
# 0. docker cp gitbook:/root/.gitbook ./offline/gitbook/
# 1. docker build -t gitbook:offline .
# 2. docker run -d -p 40000:4000 --name gitbook gitbook:offline
FROM node:12-alpine

RUN mkdir /root/books \
    && mkdir /root/.gitbook

ADD hbook/ /root/books

ADD offline/npm/ /usr/local/lib/node_modules

RUN ln -s /usr/local/lib/node_modules/gitbook-cli/bin/gitbook.js /usr/local/bin/gitbook

ADD offline/gitbook/ /root

CMD ["gitbook", "serve", "/root/books"]
