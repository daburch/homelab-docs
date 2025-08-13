FROM python:3 AS builder
WORKDIR /docs
COPY . /docs/
RUN pip install mkdocs mkdocs-material
RUN mkdocs build

FROM nginx:alpine

# Create non-root user
RUN adduser -D -u 1000 appuser

# Make sure all Nginx directories are writable
RUN mkdir -p /var/cache/nginx /var/run /var/log/nginx \
 && chown -R appuser:appuser /var/cache/nginx /var/run /var/log/nginx /usr/share/nginx/html

COPY --from=builder /docs/site /usr/share/nginx/html

# Remove or override the user directive from nginx.conf
RUN sed -i '/^user /d' /etc/nginx/nginx.conf

# Override pid file location to something writable
RUN sed -i '1i pid /tmp/nginx.pid;' /etc/nginx/nginx.conf

USER appuser

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
