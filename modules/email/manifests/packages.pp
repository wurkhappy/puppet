class email::packages{
	package { 'postfix':
	ensure => installed,
}
->
package { 'cyrus-sasl':
ensure => installed,
}
->
package { 'cyrus-imapd':
ensure => installed,
}
->
package { 'mailx':
ensure => installed,
}
}