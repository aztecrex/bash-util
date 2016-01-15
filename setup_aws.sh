# invoke STS to get session creds and put them in vars where they can
# be passed into something such as a docker container. This places creds
# in the vars expected by the CLI so they will mask any set by aws configure
#
# aws-session
# docker run -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN ...
aws-session() {
  eval "$(aws sts get-session-token \
    --query \
       'Credentials |
          join (`\n`,
           values({
             AccessKeyId: join(``, [`export AWS_ACCESS_KEY_ID=`,AccessKeyId]),
             SecretAccessKey:join(``, [`export AWS_SECRET_ACCESS_KEY=`,SecretAccessKey]),
             SessionToken:join(``, [`export AWS_SESSION_TOKEN=`,SessionToken])
           }))' \
    --output text)"
}


# invoke STS to get session creds and puts them in temp vars where they can
# be passed into something such as a docker container. This version creates vars that
# are not picked up by the aws CLI.
#
# aws-session-t
# docker run -e AWS_ACCESS_KEY_ID:T_AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY:T_AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN:T_AWS_SESSION_TOKEN ...
aws-session-t() {
  eval "$(aws sts get-session-token \
    --query \
       'Credentials |
          join (`\n`,
           values({
             AccessKeyId: join(``, [`export T_AWS_ACCESS_KEY_ID=`,AccessKeyId]),
             SecretAccessKey:join(``, [`export T_AWS_SECRET_ACCESS_KEY=`,SecretAccessKey]),
             SessionToken:join(``, [`export T_AWS_SESSION_TOKEN=`,SessionToken])
           }))' \
    --output text)"
}

# unset aws session vars of both actual and temp type
aws-clear-session() {
  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_SESSION_TOKEN
  unset T_AWS_ACCESS_KEY_ID
  unset T_AWS_SECRET_ACCESS_KEY
  unset T_AWS_SESSION_TOKEN
}

# switch profile if multi-profile is configured
aws-profile() {
  if [ "$1" = "" ]; then
    unset AWS_DEFAULT_PROFILE
  else
    export AWS_DEFAULT_PROFILE="$1"
  fi
}

# tab completion for awscli
if [ -f /usr/bin/aws_completer ]; then
  complete -C /usr/bin/aws_completer aws
elif [ -f /usr/local/bin/aws_completer ]; then
  complete -C /usr/local/bin/aws_completer aws
fi
