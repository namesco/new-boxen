class people::flyingbuddha::cron
{
    file { 'create user cron':
        path => "/var/at/tabs/${::boxen_user}",
        content => template("people/flyingbuddha/cron/mholloway"),
    }

    file { 'create root cron':
        path => "/var/at/tabs/root",
        content => template("people/flyingbuddha/cron/root"),
        owner => 'root',
    }
}
