FROM python:3 AS builder
WORKDIR /docs
COPY . /docs/
RUN pip install mkdocs mkdocs-material
RUN mkdocs build

FROM nginxinc/nginx-unprivileged:alpine-slim
COPY --from=builder /docs/site /usr/share/nginx/html
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]