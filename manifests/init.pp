node default {

  class { 'sssd':
    config_options => {
      'sssd'          => {
        'domains'             => 'LOCAL',
        'services'            => 'nss',
        'config_file_version' => '2'
      },
      'nss'           => {
        'filter_groups'       => 'root',
        'filter_users'        => 'root'
      },
      'domain/LOCAL'  => {
        'id_provider'         => 'local',
        'auth_provider'       => 'local',
        'access_provider'     => 'permit'
      }
    }
  }
}
