FROM chrislusf/seaweedfs:3.65

COPY ./config.json /config.json
COPY ./algae-entrypoint.sh /algae-entrypoint.sh

RUN chmod +x /algae-entrypoint.sh

CMD ["server -dir=/data -s3 -idleTimeout=30"]
ENTRYPOINT ["/algae-entrypoint.sh"]