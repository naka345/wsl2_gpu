# remove docker from the system completely.
dpkg -l | grep -i docker
if test $? -eq ; then
	sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli
	sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce

	sudo rm -rf /var/lib/docker /etc/docker
	sudo rm /etc/apparmor.d/docker
	sudo groupdel docker
	sudo rm -rf /var/run/docker.sock

	sudo apt-get update
else
	echo "does not exist docker..."
fi
