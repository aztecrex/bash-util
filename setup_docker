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

