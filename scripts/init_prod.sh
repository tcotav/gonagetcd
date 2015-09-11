#!/bin/bash

### install golang
wget https://storage.googleapis.com/golang/go1.5.linux-amd64.tar.gz
tar -xzvf go1.5.linux-amd64.tar.gz
sudo mv go /usr/local
export PATH=$PATH:/usr/local/go/bin
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc
export GOROOT=/usr/local/go
echo "export GOROOT=/usr/local/go" >> ~/.bashrc
echo "export GOPATH=~/go" >> ~/.bashrc
export GOPATH=~/go
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$GOROOT/bin
echo "export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$GOROOT/bin" >> ~/.bashrc
mkdir -p ~/go/src
cd ~/go

# get the etcd and any other packages you need
go get github.com/coreos/go-etcd/etcd

cd ~/go/github.com
ln -s ~/etcdhooks/src/github.com/tcotav
cd ~/go/github.com/tcotav/etcdhooks
# build the binary of our go service
go build -o etcdhooks daemon.go 

### Set up etcd
cd ~/
curl -L  https://github.com/coreos/etcd/releases/download/v2.1.2/etcd-v2.1.2-linux-amd64.tar.gz -o etcd-v2.1.2-linux-amd64.tar.gz
tar xzvf etcd-v2.1.2-linux-amd64.tar.gz
sudo mv etcd-v2.1.2-linux-amd64 /opt
cd /opt
sudo ln -s /opt/etcd-v2.1.2-linux-amd64 /opt/etcd

cd /opt/etcd
sudo cp ~/go/github.com/tcotav/etcdhooks/etcdhooks .
sudo cp ~/go/github.com/tcotav/etcdhooks/daemon.cfg .
