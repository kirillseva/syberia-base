FROM r-base:3.4.0

MAINTAINER kirillseva "https://github.com/kirillseva"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libxml2-dev \
    libpq-dev \
    s3cmd \
    && rm -rf /var/lib/apt/lists/*

RUN install2.r --error \
    --deps TRUE \
    curl \
    jsonlite \
    httr \
    yaml \
    digest \
    crayon

RUN installGithub.r \
    robertzk/lockbox@0.2.4

CMD ["R"]
