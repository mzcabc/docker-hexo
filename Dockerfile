FROM alpine
MAINTAINER Mindy Cong <mindycong@gmail.com>
ENV TZ=Asia/Shanghai
RUN apk add --update tzdata && \
    ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo "$TZ" > /etc/timezone
VOLUME ["/repo", "/html"]
RUN apk add --no-cache git && \
    apk add --update nodejs nodejs-npm && \
    rm -rf /var/cache/apk/* && \
    npm install -g --unsafe hexo-cli \
        hexo-generator-archive \
        hexo-generator-category \
        hexo-generator-index \
        hexo-generator-tag  \
        hexo-renderer-ejs \
        hexo-renderer-stylus \
        hexo-renderer-marked \
        hexo-server
    # hexo init hexo_tmp && \
    # cd hexo_tmp && \
    # npm install -g && \
    # cd / && rm -rf hexo_tmp
ADD ./docker-hexo /docker-hexo
RUN chmod +x /docker-hexo
ENTRYPOINT ["/docker-hexo"]
