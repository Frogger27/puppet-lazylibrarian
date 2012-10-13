class lazylibrarian( $source = 'true' ) {
    
    $url = "https://github.com/itsmegb/LazyLibrarian.git"
    $lazylibrarian_port = extlookup("lazylibrarian_port")
    
    include lazylibrarian::config
    
    user { 'lazylibrarian':
        allowdupe => false,
        ensure => 'present',
        uid => '604',
        shell => '/bin/bash',
        gid => '604',
        home => '/home/lazylibrarian',
        password => '*',
    }
    
    group { "lazylibrarian":
        allowdupe => false,
        ensure => present,
        gid => 603,
        name => 'lazylibrarian',
        before => User["lazylibrarian"]
    }

    file { '/home/lazylibrarian':
        ensure => directory,
        owner => 'lazylibrarian',
        group => 'lazylibrarian',
        mode => '0644',
    }
    
    exec { 'download-lazylibrarian':
        command => "/usr/bin/git clone $url lazylibrarian",
        cwd     => '/usr/local',
        creates => "/usr/local/lazylibrarian",
    }
    
    file { "/usr/local/lazylibrarian":
        ensure => directory,
        owner => 'lazylibrarian',
        group => 'lazylibrarian',
        mode => '0644',
    }

    file { "/etc/init.d/lazylibrarian":
        content => template('lazylibrarian/init-rhel.erb'),
        owner => 'root',
        group => 'root',
        mode => '0755',
    }  
}
