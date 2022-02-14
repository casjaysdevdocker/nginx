#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202202020147-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.com
# @License       : WTFPL
# @ReadME        : docker-entrypoint --help
# @Copyright     : Copyright: (c) 2022 Jason Hempstead, Casjays Developments
# @Created       : Wednesday, Feb 02, 2022 01:47 EST
# @File          : docker-entrypoint
# @Description   :
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
APPNAME="$(basename "$0")"
VERSION="202202020147-git"
USER="${SUDO_USER:-${USER}}"
HOME="${USER_HOME:-${HOME}}"
SRC_DIR="${BASH_SOURCE%/*}"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set bash options
if [[ "$1" == "--debug" ]]; then shift 1 && set -xo pipefail && export SCRIPT_OPTS="--debug" && export _DEBUG="on"; fi
trap 'exitCode=${exitCode:-$?};[ -n "$DOCKER_ENTRYPOINT_TEMP_FILE" ] && [ -f "$DOCKER_ENTRYPOINT_TEMP_FILE" ] && rm -Rf "$DOCKER_ENTRYPOINT_TEMP_FILE" &>/dev/null' EXIT

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
HOSTADMIN="${HOSTADMIN:-admin@localhost}"
SSL="${SSL:-}"

export TZ="${TZ:-America/New_York}"
export HOSTNAME="${HOSTNAME:-casjaysdev-nginx}"

[ -n "${TZ}" ] && echo "${TZ}" >/etc/timezone
[ -n "${HOSTNAME}" ] && echo "${HOSTNAME}" >/etc/hostname
[ -n "${HOSTNAME}" ] && echo "127.0.0.1 $HOSTNAME localhost" >/etc/hosts
[ -f "/usr/share/zoneinfo/${TZ}" ] && ln -sf "/usr/share/zoneinfo/${TZ}" "/etc/localtime"

if [ -f "/config/ssl/server.crt" ] && [ -f "/config/ssl/server.key" ]; then
  SSL="on"
  SSL_CERT="/config/ssl/server.crt"
  SSL_KEY="/config/ssl/server.key"
  if [ -f "/config/ssl/ca.crt" ]; then
    cat "/config/ssl/ca.crt" >>"/etc/ssl/certs/ca-certificates.crt"
  fi
elif [ "$SSL" = "on" ]; then
  create-ssl-cert "/config/ssl"
fi
update-ca-certificates

if [ "$SSL" = on ] && [ -z "$CONFIG" ]; then
  CONFIG="/nginx/config/nginx/nginx.ssl.conf"
else
  CONFIG="${NGINX_CONF:-/config/nginx/config/nginx/nginx.conf}"
fi

case "$1" in
healthcheck)
  if curl -q -LSsf -o /dev/null -s -w "200" "http://localhost/server-health"; then
    echo "OK"
    exit 0
  else
    echo "FAIL"
    exit 10
  fi
  ;;

bash | shell | sh)
  exec /bin/bash -l
  ;;

*)
  exec nginx -q -c "$CONFIG"
  ;;
esac
