#!/bin/bash
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
	"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
	$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
	sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
if lsblk | grep -q xvdf; then
	mkfs -t ext4 /dev/xvdf # Formats EBS volume attached with ext4 (prepping it as a file system)
	mkdir /mnt/data # Creating a mounting folder
	mount /dev/xvdf /mnt/data # Mounts the volume 
	echo "/dev/xvdf /mnt/data ext4 defaults,nofail 0 2" >> /etc/fstab # Adds a line into /etc/fstab so that it will remain mounted even after restart
fi
