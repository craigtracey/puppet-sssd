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

class sssd::config(
  $config_file    = $::sssd::params::config_file,
  $config_owner   = $::sssd::params::config_owner,
  $config_group   = $::sssd::params::config_group,
  $config_mode    = '0600',
  $config_options = {}
) {

  file { 'sssd-config':
    ensure  => 'present',
    name    => $config_file,
    owner   => $config_owner,
    group   => $config_group,
    mode    => $config_mode,
    content => template('sssd/sssd.conf.erb'),
    notify  => Service['sssd-service']
  }

}
