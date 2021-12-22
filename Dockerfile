FROM hashicorp/terraform:1.1.2

RUN apk update && apk add bash

COPY terraform /terraform
COPY run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
