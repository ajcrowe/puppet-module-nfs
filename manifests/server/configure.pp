class nfs::server::configure {

  concat {'/etc/exports': 
    require => Package['nfs-kernel-server']
  }


  concat::fragment{
    'nfs_exports_header':
      target  => '/etc/exports',
      content => "# This file is configured through the nfs::server puppet module\n",
      order   => 01;
  }

  if $nfs::server::nfs_v4 == true {
    include nfs::server::nfs_v4::configure
  }
}
