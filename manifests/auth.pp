# Class: unbound::stub
#
# Create an unbound auth zone
#
# === Parameters:
#
# [*address*]
#   (required) IP address of master. Can be IP 4 or IP 6 (and an
#   array or a single value. To use a nondefault port for DNS communication
#   append  '@' with the port number.
#
# [*config_file*]
#   (optional) Name of the unbound config file
#
define unbound::auth (
  Variant[Array[Unbound::Address], Unbound::Address] $address,
  $zonefile = $name,
  # lint:endignore
  Optional[Stdlib::Unixpath]                         $config_file = undef,
) {
  include unbound
  $_config_file = pick($config_file, $unbound::config_file)
  concat::fragment { "unbound-auth-${name}":
    order   => '15',
    target  => $_config_file,
    content => template('unbound/auth.erb'),
  }

}
