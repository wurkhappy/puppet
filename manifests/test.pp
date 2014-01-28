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

class { 'ssh':
stage => 'setup',
}

# class{'wh_firewall':
# stage => 'setup',
# }

class{'email':
stage => 'setup',
}
