#
# Copyright 2013, Bitlancer LLC (contact@bitlancer.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

class sssd (
  $pkg_name       = $::sssd::params::pkg_name,
  $pkg_provider   = $::sssd::params::pkg_provider,
  $pkg_version    = 'present',
  $service_name   = $::sssd::params::service_name,
  $config_file    = $::sssd::params::config_file,
  $config_owner   = $::sssd::params::config_owner,
  $config_group   = $::sssd::params::config_group,
  $config_mode    = '0600',
  $config_options = {}
) inherits sssd::params {

  package { 'sssd-package':
    ensure    => $pkg_version,
    name      => $pkg_name,
    provider  => $pkg_provider,
  }

  Package['sssd-package'] -> Service['sssd-service']

  service { 'sssd-service':
    ensure  => 'running',
    name    => $service_name,
    enable  => true,
  }

  $config_hash = {
    config_file     => $config_file,
    config_owner    => $config_owner,
    config_group    => $config_group,
    config_mode     => $config_mode,
    config_options  => $config_options
  }

  $config_class = { 'sssd::config' => $config_hash }
  create_resources( 'class', $config_class )

}
