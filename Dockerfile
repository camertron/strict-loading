FROM ruby:3.3

ARG UID
ARG GID
ARG UNAME

RUN groupadd -g ${GID} ${UNAME}
RUN useradd -rm -d /home/${UNAME} -s /bin/bash -g ${GID} -u ${UID} ${UNAME}
USER ${UNAME}
