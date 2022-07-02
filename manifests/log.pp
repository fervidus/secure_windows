#
# This class centralizes log formatting for the module.
#
define secure_windows::log (
  Boolean $enabled = true,
  Enum['alert', 'crit', 'debug', 'emerg', 'err', 'info', 'notice', 'warning'] $threatlevel = 'crit',
) {
  if $enabled {
    # puppetserver.log
    case $threatlevel {
      'alert':   { alert("${facts['networking']['fqdn']}: ${title}") }    # always visible
      'crit':    { crit("${facts['networking']['fqdn']}: ${title}") }     # always visible
      'debug':   { debug("${facts['networking']['fqdn']}: ${title}") }    # visible only with -d or --debug
      'emerg':   { emerg("${facts['networking']['fqdn']}: ${title}") }    # always visible
      'err':     { err("${facts['networking']['fqdn']}: ${title}") }      # always visible
      'info':    { info("${facts['networking']['fqdn']}: ${title}") }     # visible only with -v or --verbose or -d or --debug
      'notice':  { notice("${facts['networking']['fqdn']}: ${title}") }   # always visible
      'warning': { warning("${facts['networking']['fqdn']}: ${title}") }  # always visible
      default:   { notice("${facts['networking']['fqdn']}: ${title}") }   # always visible
    }

    # puppet agent logging
    notify { "puppetagentlogger_${title}":
      withpath => false,
      message  => $title,
      loglevel => $threatlevel,
    }
  }
}
