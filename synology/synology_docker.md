- `docker ps` permission
```
$ docker ps
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get http://%2Fvar%2Frun%2Fdocker.sock/v1.39/containers/json: dial unix /var/run/docker.sock: connect: permission denied
```
- usermod
`-sh: usermod: command not found`
- `synogroup -add` 로 해결시도 -> `docker ps` 실패
```bash
$ sudo synogroup --add docker kujyp
Group Name: [docker]
Group Type: [AUTH_LOCAL]
Group ID:   [65538]
Group Members:
0:[kujyp]
```
- 원인: `docker.sock` 파일이 root 소유
```bash
$ ls -alh /var/run/docker.sock
srw-rw---- 1 root root 0 Mar  8 03:02 /var/run/docker.sock
```
- docker.sock docker group 소유로 변경 -> 해결
```bash
$ sudo chown root:docker /var/run/docker.sock
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```
