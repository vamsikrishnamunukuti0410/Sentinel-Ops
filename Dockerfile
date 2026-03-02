#stage 1: Build Stage
FROM alpine:3.19

RUN apk add --no-cache bc procps bash

RUN addgroup -S sentinelgroup && adduser sentineluser -G sentinelgroup -D

WORKDIR /app

COPY doctor.sh .

RUN chmod +x doctor.sh && chown sentineluser:sentinelgroup doctor.sh

USER sentineluser

CMD ["./doctor.sh"]

