class people::amrpinder {


    file { 'create test directory':
    	path => "/tmp/boxentest",
    	ensure => "directory",
    }

	#include projects::release
	#include projects::ppm
	#include projects::jenkins-dsls
	#include projects::website2
	#include projects::roundcube
	#include projects::callrecorderapi

	#include projects::callmessageconsumer
	include projects::callmessagewebsocketserver
	include projects::ssl
	#include projects::rabbitmq-reset
}
