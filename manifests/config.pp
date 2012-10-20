class lazylibrarian::config {

    $lazylibrarian_data = "/usr/local/lazylibrarian-data"
    $lazylibrarian_port = extlookup("lazylibrarian_port")
    $nzbmatrix_username = extlookup("nzbmatrix_username")
    $nzbmatrix_apikey = extlookup("nzbmatrix_apikey")
    $sabnzbd_host = extlookup("sabnzbd_host")
    $sabnzbd_root = extlookup("sabnzbd_root")
    $sabnzbd_apikey = extlookup("sabnzbd_apikey")

    file { "/usr/local/lazylibrarian-data":
        ensure => directory,
        owner => 'lazylibrarian',
        group => 'automators',
        recurse => 'true'
    }

    file { "/usr/local/lazylibrarian-data/config.ini":
        content => template('lazylibrarian/config.ini.erb'),
        owner => 'lazylibrarian',
        group => 'automators',
        mode => '0644',
        require => File['/usr/local/lazylibrarian-data']
    }
}