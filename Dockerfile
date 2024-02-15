FROM        postgres:16.2-alpine3.19

LABEL       maintainer="s83 <https://github.com/s83>"

ENV         BRUDI_USER="brudi" \
            BRUDI_GID="1000" \
            BRUDI_UID="1000"

COPY        --from=quay.io/mittwald/brudi:0.1 /usr/local/bin/brudi /usr/local/bin/brudi
COPY        --from=restic/restic:0.16.4 /usr/bin/restic /usr/local/bin/restic
COPY        --from=redis:7.2.4-alpine3.19 /usr/local/bin/redis-cli /usr/local/bin/redis-cli

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
                "${BRUDI_USER}" \
            && mkdir -p /home/${BRUDI_USER}/.config/rclone \
            && touch /home/${BRUDI_USER}/.config/rclone/rclone.conf

USER        ${BRUDI_USER}
WORKDIR /home/${BRUDI_USER}

ENTRYPOINT  ["brudi"]
