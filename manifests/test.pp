stage { 'setup':
before => Stage['main'],
}
stage { 'users':
before => Stage['setup'],
}
stage { 'last': }
Stage['main'] -> Stage['last']

##Users Stage
class { 'users':
stage => 'users',
}

##Setup Stage
class { 'timezone':
stage => 'setup',
region => 'Etc',
locality => 'UTC',
}

#For some reason need to run visudo after this and just resave - no changes needed. Sudoers file says syntax error when there is none
class { 'ssh':
stage => 'setup',
}

# class{'wh_firewall':
# stage => 'setup',
# }

class{'email':
stage => 'setup',
}
