FROM uolcz/ruby:latest

ENV APPDIR /vat_info
RUN mkdir $APPDIR
WORKDIR $APPDIR

ENV BUNDLE_JOBS=2 \
    BUNDLE_PATH=/gems \
    GEM_PATH=$GEM_PATH:/gems \
    PATH=$PATH:/gems/bin

ADD . .