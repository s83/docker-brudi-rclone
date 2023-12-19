FROM quay.io/mittwald/brudi

USER root
RUN apk add --no-cache --upgrade rclone \
    && mkdir -p /home/brudi/.config/rclone/ \
    && touch /home/brudi/.config/rclone/rclone.conf
USER        ${BRUDI_USER}
