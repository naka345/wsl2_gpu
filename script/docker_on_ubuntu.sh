# clean up
sudo apt-get remove -y docker docker-engine docker.io containerd runc

# install require packages
sudo apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg-agent \
	software-properties-common

# install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
	"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
	$(lsb_release -cs) \
	stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# join docker group
sudo usermod -aG docker $USER
if sudo mkdir /sys/fs/cgroup/systemd; then
	sudo mount -t cgroup -o none,name=systemd cgroup /sys/fs/cgroup/systemd
	echo "created!"
fi

sudo service docker start
echo "sudo service docker start" >> .config/fish/config.fish
docker run hello-world

# wslの場合、sudo無しでdockerを使うにはrebootが必須？
if test $? -eq 126; then
	cmd.exe /C wsl --shutdown
fi
