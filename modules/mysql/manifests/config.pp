# Internal: Prepare your system for MySQL.
#
# Examples
#
#   include mysql::config
class mysql::config(
  $port            = 13306,
  $maxconnections = 151,
  $openfileslimit = 256,
  $innodbflushlogattrxcommit = 1
) {
  require boxen::config

  $configdir  = "${boxen::config::configdir}/mysql"
  $configfile = "${configdir}/my.cnf"
  $datadir    = "${boxen::config::datadir}/mysql"
  $executable = "${boxen::config::homebrewdir}/bin/mysqld_safe"
  $logdir     = "${boxen::config::logdir}/mysql"
  $logerror   = "${logdir}/error.log"
  $socket     = "${datadir}/socket"
  $pidfile    = "${datadir}/localhost.pid"
}
