class nfs::client::debian::service {

  Service{
    require => Class['nfs::client::debian::configure']
  }

  if $::lsbdistcodename != 'wheezy' {
    service { 'portmap':
      ensure    => running,
      enable    => true,
      hasstatus => true
    } 
  }

  if $nfs::client::debian::nfs_v4 {
    service { 'nfs-common':
      ensure    => running,
      enable    => true,
      subscribe => Augeas['/etc/idmapd.conf', '/etc/default/nfs-common']
    }
  } else {
    service { 'nfs-common':
      ensure => running,
      enable    => true
    }
  }
}
