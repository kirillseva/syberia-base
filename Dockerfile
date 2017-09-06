FROM r-base:3.4.0

MAINTAINER kirillseva "https://github.com/kirillseva"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libxml2-dev \
    libpq-dev \
    postgresql \
    postgresql-contrib \
    libtiff5-dev \
    libgmp-dev \
    libssl-dev \
    s3cmd \
    git \
    curl \
    cmake \
    python2.7 \
    python-pip \
    python3-pip \
    libatlas-dev \
    liblapack-dev \
    build-essential \
    python-dev \
    gfortran \
    libblas-dev \
    && rm -rf /var/lib/apt/lists/*

RUN install2.r --error \
    --deps TRUE \
    curl \
    jsonlite \
    httr \
    yaml \
    digest \
    crayon \
    remotes

RUN installGithub.r \
    robertzk/lockbox@0.2.4.7
    
RUN mkdir -p /dev
COPY requirements.txt /dev/requirements.txt
RUN pip install -r /dev/requirements.txt

# xgboost
RUN cd /dev && git clone https://github.com/dmlc/xgboost.git \
    && cd xgboost && git checkout 0.47 && ./build.sh && cd python-package && python setup.py install

CMD ["R"]
