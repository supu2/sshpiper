FROM docker.io/busybox
LABEL maintainer="Boshi Lian<farmer1992@gmail.com>"

RUN mkdir /etc/ssh/

# Add user nobody with id 1
ARG USERID=1000
ARG GROUPID=1000
RUN addgroup -g $GROUPID -S sshpiperd && adduser -u $USERID -S sshpiperd -G sshpiperd

# Add execution rwx to user 1
RUN chown -R $USERID:$GROUPID /etc/ssh/

USER $USERID:$GROUPID
RUN mkdir -p /sshpiperd; wget -qO- https://github.com/tg123/sshpiper/releases/download/v1.2.5/sshpiperd_with_plugins_linux_x86_64.tar.gz | tar xvz -C /sshpiperd
ADD entrypoint.sh /sshpiperd

#COPY --from=builder --chown=$USERID /sshpiperd/ /sshpiperd
EXPOSE 2222

ENTRYPOINT ["/sshpiperd/entrypoint.sh"]
