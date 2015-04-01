# == Define percona::mysql_query
#
define percona::mysql_query (
  $client_auth = false,
  $query = '',
  $onlyif = '',
) {

  if ( $client_auth == true) {
    $client_auth_option = '--defaults-file=/etc/my.cnf.d/client/admin_auth.cnf'
  } else {
    $client_auth_option = ''
  }

  if ( $onlyif != '' ) {
    $exec_onlyif = $onlyif
  } else {
    $exec_onlyif = '/bin/true'
  }

  if ( $query != '' ) {
    exec { "${name}-query":
      command   => "/usr/bin/mysql ${client_auth_option} -e \"${query}\"",
      logoutput => 'on_failure',
      onlyif    => $exec_onlyif,
    }
  }
}
