#Enable remote registry service on a domain connected machine.

#Run these powershell command from an elevated window. Run each command separately. Replace insertnamehere with target computer name. 
#The first command is to enable powershell remoting on your local.

enable-psremoting -force

get-wmiobject win32_service -ComputerName insertnamehere -filter "name = 'remoteregistry'"

set-service -name remoteregistry -computer insertnamehere -StartupType Automatic

invoke-command {restart-service remoteregistry -passthru} -comp insertnamehere

#Backup the target computer's registry. Complete the remote registry changes to the machine. 
#Once completed, run the following one line scripts to stop and disable the remote registry service on the target 
#computer and then your computer.

invoke-command {stop-service remoteregistry -passthru} -comp insertnamehere

#A status window should appear indicating the service is stopped.

set-service -name remoteregistry -computer insertnamehere -StartupType Disabled

#A new line will appear for the script. Verify status by running this line:

get-service remoteregistry -ComputerName insertnamehere | select *

#The third line from the bottom will be "StartType". This should read as disabled.
