# rails 설치

## vaygrant

코드 수정은 window에서 하고 서버 활용은 vaygrant활용



### 사전 설치

- [VirtualBox 5.1.30](https://www.virtualbox.org/wiki/Download_Old_Builds_5_1)
- [vagrant 1.9.5](https://releases.hashicorp.com/vagrant/) 
  윈도우의 경우 .msi
- Git bash (작업은 git bash에서 함.)

```bash
$ mkdir vagrant
$ cd vagrant
$ vagrant init

$ mkdir vagrant
```

```ruby
# vagrant폴더에서 Vagrantfile 수정

# default server url 추가
Vagrant::DEFAULT_SERVER_URL.replace('https://vagrantcloud.com') 

# 'config.vm.box = "base"' line을
config.vm.box = "ubuntu/xenial64" 로 수정

# '# config.vm.network "forwarded_port", guest: 80, host: 8080' 주석 풀고
config.vm.network "forwarded_port", guest: 3000, host: 3000로 수정
```



## 'Vagrantfile' 있는 곳에서 실행해야 함##

```bash
# ubuntu 켜기
$ vagrant up

# ubuntu 접속
$ vagrant ssh
```



```bash
# vagrant 폴더에서 window와 ubuntu가 공유한다는 것.
~$ cd /
/$ ls
bin   etc         lib         media  proc  sbin  sys  vagrant
boot  home        lib64       mnt    root  snap  tmp  var
dev   initrd.img  lost+found  opt    run   srv   usr  vmlinuz

# vagrant 폴더가 없다면 다시 exit해서 나간 뒤에 
$vagrant halt
# 하고 다시 vagrant up부터 시작하기
```



### [Go Rails](https://gorails.com/setup/ubuntu/16.04) 2.4.4 version DownLoad

mac인 경우 mac 용으로 다운 받으면 된다.

```bash
$ curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
$ curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
$ echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

$ sudo apt-get update
$ sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn
```



### Using rbenv

```bash
$ cd
$ git clone https://github.com/rbenv/rbenv.git ~/.rbenv
$ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
$ echo 'eval "$(rbenv init -)"' >> ~/.bashrc
# refresh shell 
$ exec $SHELL

$ git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
$ echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
$ exec $SHELL

# install ruby
$ rbenv install 2.4.4
# set global
$ rbenv global 2.4.4
$ ruby -v
ruby 2.4.4p296 (2018-03-28 revision 63013) [x86_64-linux]

# install bundler
$ gem install bundler
$ rbenv rehash
```



### Installing Rails

version : 5.2.0

```bash
$ curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
$ sudo apt-get install -y nodejs

$ gem install rails -v 5.2.0
$ rbenv rehash
$ rails -v
Rails 5.2.0
```



## Ubuntu에서 할 일

```bash
# vagrant (공유)폴더로 가서 작업하기
$ cd /vagrant

# rails 생성 (app명)
$ rails new sampleApp
$ cd sampleApp

# rails web server start (rails server)
$ rails s
```



## rails 접속 URL

`localhost:3000` 으로 접속하기



### gem file 변경하면 `$ bundle install` 무조건 하기###



폴더 구성

- sampleapp : 처음 생성 및 간단한 예제
- blog : 게시판 CRUD활용
- asked : 회원가입 및 게시판