Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/focal64"
  config.vm.box_url = "https://vagrantcloud.com/ubuntu/boxes/focal64"

  config.vm.define "wilS" do |control|
    control.vm.hostname = "wilS"
    control.vm.network "private_network", ip: "192.168.56.110"
    control.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--name", "wilS"]
      v.memory = 512
      v.cpus = 1
    end
    control.vm.provision :shell, :inline => <<-SHELL
      apt-get update
      apt-get install -y curl wget git vim
    SHELL
    control.vm.provision "shell", inline: <<-SHELL
      # K3sをコントローラーモードでインストール
      curl -sfL https://get.k3s.io | sh -

      # トークンを共有ディレクトリに保存（ワーカーノードがアクセスできるように）
      # Wait for the token file to be generated
      while [ ! -f /var/lib/rancher/k3s/server/node-token ]; do
        sleep 1
      done
      sudo cp /var/lib/rancher/k3s/server/node-token /vagrant/node-token
      sudo chmod 644 /vagrant/node-token

      # K3sの状態確認
      sudo k3s kubectl get nodes
    SHELL
  end

  config.vm.define "wilSW" do |control|
    control.vm.hostname = "wilSW"
    control.vm.network "private_network", ip: "192.168.56.111"
    control.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--name", "wilSW"]
      v.memory = 512
      v.cpus = 1
    end
    control.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y curl wget git
    SHELL
    control.vm.provision "shell", inline: <<-SHELL
      # K3sをエージェントモードでインストール
      # トークンを取得
      TOKEN=$(cat /vagrant/node-token)

      # エージェントとしてK3sをインストール（マスターノードのIPアドレスとトークンを指定）
      curl -sfL https://get.k3s.io | K3S_URL=https://192.168.56.110:6443 K3S_TOKEN=$TOKEN sh -
    SHELL
  end

end