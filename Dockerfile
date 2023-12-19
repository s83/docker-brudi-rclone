FROM quay.io/mittwald/brudi

USER root
RUN apk add --no-cache --upgrade rclone \
    && touch /home/brudi/.config/rclone/rclone.conf
USER        ${BRUDI_USER}
