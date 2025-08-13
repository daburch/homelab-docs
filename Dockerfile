FROM python:3 AS builder

WORKDIR /docs
COPY . /docs/
RUN pip install mkdocs-material
RUN mkdocs build

FROM nginx:alpine
COPY --from=builder /docs/site /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]