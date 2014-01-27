stage { 'setup':
before => Stage['main'],
}
stage { 'last': }
Stage['main'] -> Stage['last']

##Setup Stage
class { 'users':
stage => 'setup',
}

class { 'timezone':
stage => 'setup',
region => 'Etc',
locality => 'UTC',
}

class { 'ssh':
stage => 'setup',
}

# class{'wh_firewall':
# stage => 'setup',
# }

class{'email':
stage => 'setup',
}
