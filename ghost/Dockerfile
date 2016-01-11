FROM ghost:0.7.4

# copy over our config file

COPY ./copy/final-config.js "$GHOST_CONTENT/config.js"

VOLUME $GHOST_CONTENT

## setup support for s3 storage
#
#RUN mkdir -p "$GHOST_CONTENT/storage/ghost-s3"
#COPY ./copy/storage/ghost-s3/index.js "$GHOST_CONTENT/storage/ghost-s3/index.js"
#
#npm install --save ghost-s3-storage

CMD ["npm", "start"]
