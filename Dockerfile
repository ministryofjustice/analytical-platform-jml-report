#checkov:skip=CKV_DOCKER_2: HEALTHCHECK not required - AWS Lambda does not support HEALTHCHECK
#checkov:skip=CKV_DOCKER_3: USER not required - A non-root user is used by AWS Lambda
FROM public.ecr.aws/lambda/python:3.12@sha256:de3bdb1f444cfbf12976b5b2a6400ff9dd4c20c35a115c15f9b420115552cdc9

LABEL org.opencontainers.image.vendor="Ministry of Justice" \
      org.opencontainers.image.authors="Analytical Platform (analytical-platform@digital.justice.gov.uk)" \
      org.opencontainers.image.title="JML Report" \
      org.opencontainers.image.description="JML report image for Analytical Platform" \
      org.opencontainers.image.url="https://github.com/ministryofjustice/analytical-platform-jml-report"

SHELL ["/bin/bash", "-e", "-u", "-o", "pipefail", "-c"]

COPY --chown=nobody:nobody --chmod=0755 src/var/task/ ${LAMBDA_TASK_ROOT}

RUN <<EOF
python -m pip install --no-cache-dir --upgrade pip==24.0

python -m pip install --no-cache-dir --requirement requirements.txt
EOF

CMD ["handler.handler"]
