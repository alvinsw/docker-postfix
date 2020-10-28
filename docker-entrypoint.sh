#!/bin/sh
postconf -e "mydestination="
postconf -e "maillog_file=/dev/stdout"
postconf -e "smtpd_milters=unix:/run/opendkim/opendkim.sock"
postconf -e "non_smtpd_milters=\$smtpd_milters"
postconf -e "milter_default_action=accept"
[ -z "$POSTFIX_NET_STYLE" ] || postconf -e "mynetworks_style=$POSTFIX_NET_STYLE"
[ -z "$POSTFIX_NET" ] || postconf -e "mynetworks=$POSTFIX_NET"
[ -z "$POSTFIX_HOSTNAME" ] || postconf -e "myhostname=$POSTFIX_HOSTNAME"

/usr/sbin/opendkim -s $OPENDKIM_SELECTOR
exec "$@"
