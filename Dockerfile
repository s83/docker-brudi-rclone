FROM        postgres:16.1-alpine3.18

LABEL       maintainer="Mittwald CM Service <https://github.com/mittwald>"

ENV         BRUDI_USER="brudi" \
            BRUDI_GID="1000" \
            BRUDI_UID="1000"

COPY        --from=quay.io/mittwald/brudi:0.1 /usr/local/bin/brudi /usr/local/bin/brudi
COPY        --from=restic/restic:0.11.0 /usr/bin/restic /usr/local/bin/restic
COPY        --from=redis:alpine /usr/local/bin/redis-cli /usr/local/bin/redis-cli

RUN         apk add --no-cache --upgrade \
                mysql-client \
                rclone \
                curl \
            && \
            addgroup \
                -S "${BRUDI_USER}" \
                -g "${BRUDI_GID}" \
            && \
            adduser \
                -u "${BRUDI_UID}" \
                -S \
                -G "${BRUDI_USER}" \
                "${BRUDI_USER}"

USER        ${BRUDI_USER}
WORKDIR /home/${BRUDI_USER}

ENTRYPOINT  ["brudi"]
