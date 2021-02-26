alias update-gimme="docker pull smartthings-docker-deploy.jfrog.io/docker-deploy/gimme-aws-creds:latest"
alias gimme-global="touch ~/.okta_aws_login_config && docker run -it --rm \
  -v ~/.aws/credentials:/root/.aws/credentials \
  -v ~/.okta_aws_login_config:/root/.okta_aws_login_config \
  smartthings-docker-deploy.jfrog.io/docker-deploy/gimme-aws-creds:latest -p aws-global"
alias gimme-cn="touch ~/.okta_aws_login_config && docker run -it --rm \
  -v ~/.aws/credentials:/root/.aws/credentials \
  -v ~/.okta_aws_login_config:/root/.okta_aws_login_config \
  smartthings-docker-deploy.jfrog.io/docker-deploy/gimme-aws-creds:latest -p aws-cn"
alias gimme="gimme-global && gimme-cn"

function asp {
  if [[ -z "$1" ]]; then
    if [[ -z "$AWS_PROFILE" ]]; then
      echo "No profile set"
    else
      asp "$AWS_PROFILE"
      echo "$AWS_PROFILE"
    fi
  else
    if [[ "$1" == "--list" ]];
    then
        cat ~/.aws/config |grep --color=never '\[profile'|grep -v ^#|awk '{print $2}'|tr -d ']'
        cat ~/.aws/credentials|grep --color=never '^\['|tr -d '[]'
    elif [[ "$1" == "--unset" ]]; then
      unset AWS_PROFILE
    elif fgrep -q "[profile $1]" ~/.aws/config; then
      export AWS_PROFILE="$1"
    elif fgrep -q "[$1]" ~/.aws/credentials; then
      export AWS_PROFILE="$1"
    else
      echo "No such profile"
    fi
  fi
}

function tsh2() {
	 #net host not the best but there isn't a set port for the login
	docker run --rm -it \
		--entrypoint "tsh"  \
		--volume "${HOME}/.tsh:/root/.tsh" \
		--net host \
		--name tsh \
		quay.io/gravitational/teleport:4.3 "$@"
}


