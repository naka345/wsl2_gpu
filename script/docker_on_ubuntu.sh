sudo apt-get remove -y docker docker-engine docker.io containerd runc

sudo apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg-agent \
	software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
	"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
	$(lsb_release -cs) \
	stable"

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker $USER
if sudo mkdir /sys/fs/cgroup/systemd; then
	sudo mount -t cgroup -o none,name=systemd cgroup /sys/fs/cgroup/systemd
	echo "created!"
fi

sudo service docker start
echo "sudo service docker restart" >> .config/fish/config.fish
sudo service docker restart
docker run hello-world

if test $? -eq 126; then
	wslreboot
fi