# https://docs.docker.com/engine/reference/commandline/ps/#filtering
docker ps -f ancestor=mysql:5.7.28
#> CONTAINER ID        IMAGE               COMMAND                  CREATED              STATUS              PORTS                               NAMES
#> d9950e851a60        mysql:5.7.28        "docker-entrypoint.s…"   About a minute ago   Up About a minute   33060/tcp, 0.0.0.0:3307->3306/tcp   mysql_migrate
#> 41d84d437ae6        mysql:5.7.28        "docker-entrypoint.s…"   3 hours ago          Up 3 hours          0.0.0.0:3306->3306/tcp, 33060/tcp   mysql

docker ps -q -f ancestor=mysql:5.7.28
#> d9950e851a60
#> 41d84d437ae6

docker ps -q -f ancestor=mysql:5.7.28 -n 1
#> d9950e851a60
