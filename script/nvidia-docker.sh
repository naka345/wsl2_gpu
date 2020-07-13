# uninstall cuda and nvidia lib
sudo apt-get --purge remove -y nvidia-*
sudo apt-get --purge remove -y cuda-*

# install cuda (onry cuda-toolkit)
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
sudo sh -c 'echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list'
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y cuda-toolkit-11-0
echo "set -x PATH /usr/local/cuda-11.0/bin \$PATH" >> .config/fish/config.fish
echo "set -x LD_LIBRARY_PATH /usr/local/cuda-11.0/lib64 \$LD_LIBRARY_PATH" >> .config/fish/config.fish
source .config/fish/config.fish

# recognized GPU
cd /usr/local/cuda/samples/4_Finance/BlackScholes
sudo make
./BlackScholes

cd ~

# install nvidia-docker2
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
curl -s -L https://nvidia.github.io/libnvidia-container/experimental/$distribution/libnvidia-container-experimental.list | sudo tee /etc/apt/sources.list.d/libnvidia-container-experimental.list

sudo apt-get update && sudo apt-get install -y nvidia-docker2
sudo service docker restart

# runnung cuda benchmark
docker run --gpus all nvcr.io/nvidia/k8s/cuda-sample:nbody nbody -gpu -benchmark
