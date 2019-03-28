# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include file_content
class file_content {
  file { '/etc/cron.allow':
    ensure => file,
}
  file_line { 'prevent cron from doing stuff':
    ensure => present,
    path   => '/etc/cron.deny',
    line   => '*',
  }
  file_line { 'allow root to cron away':
    ensure => present,
    path   => '/etc/cron.allow',
    line   => 'root',
  }
  concat { '/etc/motd':
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }
  concat::fragment { 'motd header':
    target  => '/etc/motd',
    order   => '01',
    content => epp('file_content/motd_header.epp'),
  }
  concat::fragment { 'sample motd message':
    target  => '/etc/motd',
    order   => '50',
    content => 'Long live the King',
  }
}

