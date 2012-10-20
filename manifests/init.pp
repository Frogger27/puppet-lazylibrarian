class lazylibrarian {
    
    $url = "https://github.com/itsmegb/LazyLibrarian.git"
    $lazylibrarian_port = extlookup("lazylibrarian_port")
    
    include lazylibrarian::config
    
    user { 'lazylibrarian':
        allowdupe => false,
        ensure => 'present',
        uid => '606',
        shell => '/bin/bash',
        gid => '700',
        home => '/home/lazylibrarian',
        password => '*',
    }

    file { '/home/lazylibrarian':
        ensure => directory,
        owner => 'lazylibrarian',
        group => 'automators',
        mode => '0644',
        recurse => 'true'
    }
    
    exec { 'download-lazylibrarian':
        command => "/usr/bin/git clone $url lazylibrarian",
        cwd     => '/usr/local',
        creates => "/usr/local/lazylibrarian",
    }
    
    file { "/usr/local/lazylibrarian":
        ensure => directory,
        owner => 'lazylibrarian',
        group => 'automators',
        mode => '0644',
        recurse => 'true'
    }

    file { "/etc/init.d/lazylibrarian":
        content => template('lazylibrarian/init-rhel.erb'),
        owner => 'root',
        group => 'root',
        mode => '0755',
    }  
}
