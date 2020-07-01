# WSL om docker desktop
sudo gpasswd -a $USER docker 
sudo mkdir /sys/fs/cgroup/systemd
sudo mount -t cgroup -o none,name=systemd cgroup /sys/fs/cgroup/systemd
docker run hello-world