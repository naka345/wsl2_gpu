sudo apt-add-repository -y ppa:fish-shell/release-2
sudo apt-get update
sudo apt-get install -y fish


curl -L https://get.oh-my.fish > fish_install
fish fish_install --noninteractive
rm fish_install
fish -c "omf update omf"
fish -c "omf install https://github.com/FabioAntunes/fish-nvm"
fish -c "omf install https://github.com/jethrokuan/fzf"
fish -c "omf install sushi"

echo "alias wslreboot='cmd.exe /C wsl --shutdown'" > ~/.bashrc

ssh-keygen -t rsa -b 4096 -C "naka345@gmail.com"
echo "eval (ssh-agent -c)" >> ~/.config/fish/config.fish
echo "ssh-add ~/.ssh/id_rsa" >> ~/.config/fish/config.fish

sudo apt install -y git
git config --list
git config --global user.name "naka345"
git config --global user.email "naka345@gmail.com"
cat ~/.ssh/id_rsa.pub
git clone git@github.com:naka345/qiita_product.git

echo "exec fish" >> .bashrc
cmd.exe /C wsl --shutdown