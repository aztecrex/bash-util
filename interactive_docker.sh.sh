
using-docker-machine() {
  $(am-mac)
}

if $(using-docker-machine); then
start-docker() {
  local name=${1-default}
  docker-machine start $name
  docker-machine regenerate-certs -f $name
  attach-docker $*
}
stop-docker() {
  detach-docker
  docker-machine stop ${1-default}
}
attach-docker() {
  eval $(docker-machine env ${1-default})
}
detach-docker() {
  unset DOCKER_TLS_VERIFY
  unset DOCKER_HOST
  unset DOCKER_CERT_PATH
  unset DOCKER_MACHINE_NAME
}
fi


# invoke STS to get session creds and put them in vars where they can
# be passed into something such as a docker container. This places creds
# in the vars expected by the CLI so they will mask any set by aws configure
#
# aws-session
# docker run -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN ...
aws-docker-run() {
  eval "$(aws sts get-session-token \
    --query \
       'Credentials |
          join (`\n`,
           values({
             AccessKeyId: join(``, [`local aid=`,AccessKeyId]),
             SecretAccessKey:join(``, [`local asecret=`,SecretAccessKey]),
             SessionToken:join(``, [`local atoken=`,SessionToken])
           }))' \
    --output text)"
    docker run -e AWS_ACCESS_KEY_ID=$aid -e AWS_SECRET_ACCESS_KEY=$asecret -e AWS_SESSION_TOKEN=$atoken $*
}
