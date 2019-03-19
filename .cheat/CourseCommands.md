# ToDo
 - Update all these
    ```ruby
    content
    ```

 - Update commands in setting up ring (removed IP and use VM-1 etc)

# Course Commands
## 01-Introduction
n/a

## 02-What_is_Habitat
```bash
ssh chef@<YOUR IP ADDRESS>
chef@workstation:~$ cd ~
chef@workstation:~$ touch <your first_last name>
chef@workstation:~$ ls
chef@workstation:~$ curl https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh | sudo bash
chef@workstation:~$ hab --version
chef@workstation:~$ sudo hab sup run chef-training/nodejs_demo
```

## 03_Habitat_Environment_Setup
<UI>
  - create account at https://github.com (if dont have one)
  - Log into https://bldr.habitat.sh
  - Set up your Habitat Origin
  - Set up Habitat Access Token
</UI>

```bash
chef@workstation:~$ hab setup
  Connect to an on-premises bldr instance? [Yes/no/quit] No
  ...
  Set up a default origin? [Yes/no/quit] Yes
  ...
  Default origin name: [default: chef] <your origin created earlier>
  ...
  Create an origin key for '<your origin>'? [Yes/no/quit] Yes
  ...
  Set up a default Habitat personal access token? [Yes/no/quit] Yes
  ...
  Habitat personal access token: <paste your personal access token here>
  ...
  Set up a default Habitat Supervisor CtlGateway secret? [Yes/no/quit] no
  ...
  Enable analytics? [Yes/no/quit] no
```

```bash
chef@workstation:~$ ls ~/.hab/cache/keys/
chef@workstation:~$ cat ~/.hab/etc/cli.toml
```


## 04_Building_Artifacts_1
```bash
chef@workstation:~$ git clone https://github.com/<username>/habitat_essentials_content
chef@workstation:~$ cd habitat_essentials_content
chef@workstation:~$ ls
chef@workstation:~$ cd nodejs_demo
chef@workstation:~$ tree -LF 1
chef@workstation:~$ cd ~/habitat_essentials_repo/nodejs_demo
chef@workstation:~$ hab plan init
chef@workstation:~$ tree habitat -F
chef@workstation:~$ cat habitat/plan.sh
chef@workstation:~$ cd ~/habitat_essentials_content/nodejs_demo
chef@workstation:~$ hab studio enter
```

```bash
[1][default:/src:0]\# pwd
[2][default:/src:0]\# ls
[4][default:/src:0]\# build
[5][default:/src:0]\# ls –l results
[5][default:/src:0]\# head –n 4 results/myorigin-nodejs_demo-0.1.0-20180804101313-x86_64-linux.hart
[6][default:/src:0]\# cat results/last_build.env
[7][default:/src:0]\# source results/last_build.env
[8][default:/src:0]\# hab svc load $pkg_ident
[9][default:/src:0]\# curl http://localhost:8000
[11][default:/src:0]\# hab pkg provides curl
[12][default:/src:0]\# hab pkg install core/curl -b
[13][default:/src:0]\# curl http://localhost:8000
[1][default:/src:0]\# exit
```

```bash
chef@workstation:~$ source results/last_build.env
chef@workstation:~$ hab pkg upload results/$pkg_artifact
chef@workstation:~$ hab pkg promote $pkg_ident stable
```


## 05_Habitat Output Formats
```bash
chef@workstation:~$ sudo hab pkg export docker results/$pkg_artifact
chef@workstation:~$ sudo docker image ls
chef@workstation:~$ source results/last_docker_export.env
chef@workstation:~$ sudo docker run -it -p 8001:8000 $name
chef@workstation:~$ sudo hab pkg export tar results/$pkg_artifact
chef@workstation:~$ ls
chef@workstation:~$ sudo tar xvf myorigin-nodejs_demo-0.1.0-20180804152015.tar.gz -C /tmp
chef@workstation:~$ rm myorigin-nodejs_demo-0.1.0-20180804152015.tar.gz
chef@workstation:~$ cd /tmp
chef@workstation:~$ tree hab –L 2
chef@workstation:~$ tree -L 2 /tmp/hab/pkgs
chef@workstation:~$ ls /tmp/hab/pkgs/core/
chef@workstation:~$ tree -L 4 /tmp/hab/pkgs/myorigin/nodejs_demo
```

## 06_Dynamic Configuration
```bash
chef@workstation:~$ cd ~/habitat_essentials_content/nodejs_demo
chef@workstation:~$ hab studio enter
[4][default:/src:0]\# source results/last_build.env
[4][default:/src:0]\# hab pkg config $pkg_ident
[13][default:/src:0]\# cat public/stylesheets/style.css
[13][default:/src:0]\# cp public/stylesheets/style.css habitat/config/
[13][default:/src:0]\# vi habitat/config/style.css
```

```ruby
files/....
```
[13][default:/src:0]\# vi habitat/default.toml
```ruby
content
```
[13][default:/src:0]\# vi habitat/hooks/init
```ruby
content
```

```bash
[13][default:/src:0]\# source results/last_build.env
[13][default:/src:0]\# hab svc unload $pkg_ident
[13][default:/src:0]\# build
[13][default:/src:0]\# source results/last_build.env
[13][default:/src:0]\# hab svc load $pkg_ident --group=qa  
[13][default:/src:0]\# vi config_update.toml
[13][default:/src:0]\# hab config apply nodejs_demo.qa 2 config_update.toml && sup-log
[13][default:/src:0]\# curl http://localhost:8000
[13][default:/src:0]\# hab pkg config $pkg_ident
```


## 07_Service Bindings
```bash
[1][default:/src:0]\# hab sup status
[1][default:/src:0]\# curl -s http://localhost:9631/services
[1][default:/src:0]\# hab pkg provides jq
[1][default:/src:0]\# curl -s http://localhost:9631/services | jq
[1][default:/src:0]\# curl -s http://localhost:9631/services | jq
[1][default:/src:0]\# hab pkg install core/jq-static –b
[1][default:/src:0]\# exit
```

```bash
chef@workstation:~$ mkdir -p ~/habitat_essentials_content/haproxy_demo
chef@workstation:~$ cd ~/habitat_essentials_content/haproxy_demo
chef@workstation:~$ hab plan init
chef@workstation:~$ tree ~/habitat_essentials_content/haproxy_demo
chef@workstation:~$ cd /home/chef/habitat_essentials_content
chef@workstation:~$ hab studio enter
```

```bash
vi haproxy_demo/habitat/plan.sh
vi haproxy_demo/habitat/default.toml
vi haproxy_demo/habitat/config/haproxy.conf
```

```bash
[1][default:/src:0]\# build haproxy_demo
[2][default:/src:0]\# ls results
[2][default:/src:0]\# source results/last_build.env
[3][default:/src:0]\# hab svc load $pkg_ident --group test
[2][default:/src:0]\# sup-log
[3][default:/src:0]\# hab svc unload $pkg_ident
[2][default:/src:0]\# mv results/last_build.env results/last_build.haproxy.env
```

```bash
vi nodejs_demo/habitat/plan.sh
```

```bash
[1][default:/src:0]\# build nodejs_demo
[1][default:/src:0]\# source results/last_build.env
[1][default:/src:0]\# hab svc load $pkg_ident --group=qa
[1][default:/src:0]\# hab pkg install core/curl -b
[1][default:/src:0]\# curl http://localhost:8000
[1][default:/src:0]\# source results/last_build.haproxy.env
[1][default:/src:0]\# hab svc load $pkg_ident --group=qa --bind backend:nodejs_demo.qa
[1][default:/src:0]\# sup-log
[1][default:/src:0]\# hab sup status
[1][default:/src:0]\# curl http://localhost:80
[1][default:/src:0]\# hab pkg install core/jq-static –b
[1][default:/src:0]\# curl -s http://localhost:9631/services/nodejs_demo/qa/config | jq
[1][default:/src:0]\# curl -s http://localhost:9631/services/haproxy_demo/qa/config | jq
[1][default:/src:0]\# curl -s http://localhost:9631/services/nodejs_demo/qa/health | jq
[1][default:/src:0]\# curl -s http://localhost:9631/services/haproxy_demo/qa/health | jq
[1][default:/src:0]\# exit
```

```bash
chef@workstation:~$ source results/last_build.haproxy.env
chef@workstation:~$ hab pkg upload results/$pkg_artifact –c stable
chef@workstation:~$ source results/last_build.env
chef@workstation:~$ hab pkg upload results/$pkg_artifact –c stable
```

## 08_Creating a Supervisor Ring

<<REDO THESE VM-1, VM-2, etc>>

```bash
chef@18.232.110.83:~$ sudo hab sup run myorigin/nodejs_demo --group=qa
chef@100.26.206.12:~ $ sudo hab sup run myorigin/haproxy_demo --group=qa--peer <VM1 IPAddress> --bind backend:nodejs_demo.qa
chef@100.26.206.12:~ $ sudo hab sup run myorigin/haproxy_demo --group=qa--peer <VM1 IPAddress> --bind backend:nodejs_demo.qa
http://VM2-IPAddress:80
chef@workstation:~ $ ssh chef@100.26.206.12
chef@100.26.206.12:~ $ sudo cat /hab/svc/haproxy_demo/config/haproxy.conf
chef@18.207.247.63:~$ sudo hab sup run myorigin/nodejs_demo --group=qa --peer 100.26.206.12
chef@100.26.206.12:~ $ sudo cat /hab/svc/haproxy_demo/config/haproxy.conf
chef@100.26.206.12:~ $ sudo hab sup term

chef@workstation:~$ cd /home/chef/habitat_essentials_content
chef@workstation:~$ hab sup secret generate
chef@workstation:~$ hab setup
Habitat Supervisor CtlGateway secret:
chef@workstation:~$ cat ~/.hab/etc/cli.toml

chef@34.226.136.36:~ $ echo -n
chef@18.207.247.63:~ $ echo -n
chef@100.26.206.12:~ $ echo -n

chef@34.226.136.36:~ $ sudo hab sup run myorigin/nodejs_demo --group=qa --listen-ctl=0.0.0.0:9632
chef@18.207.247.63:~ $ sudo hab sup run myorigin/nodejs_demo --group=qa --peer 34.226.136.36--listen-ctl=0.0.0.0:9632
chef@100.26.206.12:~ $ sudo hab sup run myorigin/haproxy_demo --group=qa --bind backend:nodejs_demo.qa --peer 34.226.136.36 --listen-ctl=0.0.0.0:9632
```

```bash
chef@workstation:~$ vi nodejs_update.toml
chef@workstation:~$ hab config apply nodejs_demo.qa $(date +%s) nodejs_update.toml --remote-sup=18.207.247.63
chef@workstation:~$ cat haproxy_demo/habitat/default.toml
chef@workstation:~$ vi haproxy_update.toml
chef@workstation:~$ hab config apply haproxy_demo.qa $(date +%s) haproxy_update.toml --remote-sup=34.226.136.36
chef@workstation:~$ curl -s http://34.226.136.36:9631/butterfly | jq


chef@workstation:~$ sudo hab pkg export docker myorigin/nodejs_demo
chef@workstation:~$ sudo hab pkg export docker myorigin/haproxy_demo

chef@workstation:~$ vi docker-compose.yml

chef@workstation:~$ sudo docker-compose up –d
chef@workstation:~$ sudo docker-compose logs -f
```

## 09_Habitat Builder
```bash
local:~$ git clone git@github.com:<git-username>/habitat_essentials_content.git
local:~$ cd habitat_essentials_content
local:~$ git checkout master
local:~$ git merge builder-lesson
local:~$ cat nodejs_demo/habitat/plan.sh
local:~$ cat haproxy_demo/habitat/plan.sh
local:~$ git commit -am "Updated origin"
local:~$ git push origin master
```

```bash
chef@workstation:~$ sudo hab sup run myorigin/nodejs_demo --group=production --channel stable --strategy at-once
```

<UI>
 - Connect your plan
</UI>

```bash
local:~$ vi nodejs_demo/habitat/default.toml
local:~$ vi nodejs_demo/habitat/plan.sh
```

<UI>
 - Create repository on Docker Hub
 - Create the integration
</UI>

local:~$ docker run -it -p 8001:8000 YourDockerID/nodejs_demo



## 0_Habitat Plans – A Deeper Dive
```bash
chef@workstation:~$ cd habitat_essentials_content/national-parks
chef@workstation:~$ hab plan init
chef@workstation:~$ cat habitat/plan.sh
chef@workstation:~$ vi habitat/plan.sh
chef@workstation:~$ vi habitat/hooks/init
chef@workstation:~$ vi habitat/hooks/run
chef@workstation:~$ vi habitat/default.toml
chef@workstation:~$ hab studio enter
```

```bash
[1][default:/src:0]\# build
[1][default:/src:0]\# vi habitat/plan.sh
[1][default:/src:0]\# build
[1] national-parks(do_install)> help
[1] national-parks(do_install)> vars
[1] national-parks(do_install)> pwd
[2] national-parks(do_install)> echo $HAB_CACHE_SRC_PATH
[3] national-parks(do_install)> echo $PREFIX
[4] national-parks(do_install)> hab pkg path core/tomcat8
[5] national-parks(do_install)> ls /hab/pkgs/core/tomcat8/8.5.9/20180609193916
[8] national-parks(do_install)> exit
```

```bash
[1][default:/src:0]\# vi habitat/plan.sh
[1][default:/src:0]\# build
[1][default:/src:0]\# source results/last_build.env
[1][default:/src:0]\# hab pkg export docker results/$pkg_artifact
[1][default:/src:0]\# exit
```

```bash
chef@workstation:~$ source results/last_docker_export.env
chef@workstation:~$ sudo docker run -it -p 8080:8080 $name
chef@workstation:~$ cat data/national-parks.json
chef@workstation:~$ vi habitat/hooks/init
chef@workstation:~$ vi habitat/hooks/run
chef@workstation:~$ vi habitat/default.toml
chef@workstation:~$ vi habitat/mongo.toml
chef@workstation:~$ hab studio enter
```

```bash
[1][default:/src:0]\# build
[1][default:/src:0]\# source results/last_build.env
[3][default:/src:0]\# hab svc load core/mongodb
[4][default:/src:0]\# hab config apply mongodb.default $(date +%s) habitat/mongo.toml
[5][default:/src:0]\# hab svc load $pkg_origin/$pkg_name --bind database:mongodb.default
```

```bash
chef@workstation:~$ vi habitat/haproxy.toml
chef@workstation:~$ hab studio enter
```

```bash
[1][default:/src:0]\# build
[2][default:/src:0]\# source results/last_build.env
[3][default:/src:0]\# hab pkg export docker core/mongodb
[4][default:/src:0]\# hab pkg export docker core/haproxy
[5][default:/src:0]\# hab pkg export docker results/$pkg_artifact
[6][default:/src:0]\# exit
```

```bash
chef@workstation:~$ vi docker-compose.yml
chef@workstation:~$ sudo docker-compose up -d
chef@workstation:~$ sudo docker-compose logs –f
chef@workstation:~$ HAPROXY_DOCKER_ID=$(sudo docker ps|grep 'haproxy'|awk '{print $1}')
chef@workstation:~$ sudo docker exec $HAPROXY_DOCKER_ID cat /hab/svc/haproxy/config/haproxy.conf
chef@workstation:~$ HAPROXY_DOCKER_ID=$(sudo docker ps|grep 'haproxy'|awk '{print $1}')
chef@workstation:~$ sudo docker exec $HAPROXY_DOCKER_ID cat /hab/svc/haproxy/config/haproxy.conf
chef@workstation:~$ sudo hab sup run --peer=172.17.0.4
chef@workstation:~$ vi habitat/haproxy.toml
chef@workstation:~$ sudo hab config apply haproxy.default $(date +%s) habitat/haproxy.toml
```
