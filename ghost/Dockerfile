FROM ghost:0.11.0

## setup support for s3 storage

ENV GHOST_STORAGE_S3 $GHOST_SOURCE/content/storage/ghost-s3

RUN mkdir -p $GHOST_STORAGE_S3 \
    && cd $GHOST_STORAGE_S3 \
    && npm install --prefix . ghost-s3-service

COPY ./copy/index.js $GHOST_STORAGE_S3

## override ghost entrypoint so we can add a wait for the database to initialize

COPY ./copy/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["npm", "start"]

