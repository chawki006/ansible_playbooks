############### Visual Studio Code ###############

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

############### Google Chrome ###############
http_size=$(curl --head https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb | grep "content-length" | cut -f 2 -d ' ' | sed 's/[^[:print:]]//' )
local_size=$(ls -la google-chrome-stable_current_amd64.deb | cut -f 5 -d ' ')
if [[ ! "$http_size" == "$local_size" ]]; then
    echo "File doesn't exist or not downloaded correctly";
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
fi
sudo dpkg -i google-chrome-stable_current_amd64.deb

############### Slack ###############
sudo snap install slack --classic


sudo apt update
sudo apt install tilda tmux apt-transport-https code htop vim nethogs git -y

############### Startup applications ###############
mkdir -p /home/chawki/.config/autostart
echo "
[Desktop Entry]
Name=Slack
Exec=slack
Type=Application" > /home/chawki/.config/autostart/slack.desktop

echo "
[Desktop Entry]
Name=Tilda
Exec=tilda
Type=Application" > /home/chawki/.config/autostart/tilda.desktop

