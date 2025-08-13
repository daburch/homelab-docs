FROM python:3 AS builder

WORKDIR /docs
COPY . /docs/
RUN pip install mkdocs mkdocs-material
RUN mkdocs build

FROM nginx:alpine

# Create a non-root user
RUN adduser -D -u 1000 appuser

# Fix permissions for Nginx cache directories
RUN chown -R 1000:1000 /var/cache/nginx /var/run /var/log/nginx

COPY --from=builder /docs/site /usr/share/nginx/html

USER appuser

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]