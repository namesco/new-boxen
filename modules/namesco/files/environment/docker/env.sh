# The docker-machine (DM) docker daemon (daemon) has been noted to be unstable
# on startup, such that when certain docker/docker-machine commands are executed
# on the DM host, the daemon refuses to respond. A full DM stop/start fixes the
# issue.
#
# In order to smooth over this crack the following approach is taken to ensure
# the named docker-machine is always started and in a usable state:
# 
# 1) Poke the DM (issue a suitable docker-machine command)
# 2) Ascertain the state of the DM & daemon
# 3) Stop / start cycle the DM as required
# 4) Ensure the Docker environment variables are exported

DM_NAME="dev"
DM_CHECK_CONTAINER="proxy"
DM_RUNNING=false
DM_PROXY_RUNNING=false

function pokeDockerMachine {
	docker-machine env $DM_NAME &>/dev/null
}

function exportDockerMachineEnv {
	eval $(docker-machine env $DM_NAME 2>/dev/null)
	echo "Exported environment variables for Docker machine '$DM_NAME'"
}

function getDockerMachineState {
	[[ ! `docker-machine ls | grep ^$DM_NAME.*Stopped` ]] && DM_RUNNING=true
	[[ `docker-machine ssh $DM_NAME docker ps 2>/dev/null | grep $DM_CHECK_CONTAINER` ]] && DM_PROXY_RUNNING=true
	#echo "DM_RUNNING: $DM_RUNNING"
	#echo "DM_PROXY_RUNNING: $DM_PROXY_RUNNING"
}

function ensureCleanStart {
	if [[ "$DM_RUNNING" = true && "$DM_PROXY_RUNNING" = true ]];
	then
		echo "Docker machine '$DM_NAME' running, '$DM_CHECK_CONTAINER' container running"
	elif [[ "$DM_RUNNING" = true && "$DM_PROXY_RUNNING" = false ]];
	then
		echo "Docker machine '$DM_NAME' running, '$DM_CHECK_CONTAINER' container not running (stop/starting DM)"
		docker-machine stop $DM_NAME
		docker-machine start $DM_NAME
	elif [[ "$DM_RUNNING" = false ]];
	then
		echo "Docker machine '$DM_NAME' not running (starting DM)"
		docker-machine start $DM_NAME
	fi
}

# Run
pokeDockerMachine
getDockerMachineState
ensureCleanStart
exportDockerMachineEnv
