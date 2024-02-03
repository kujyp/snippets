### flexget
- 직접 설치 vs. docker
  - 시놀로지 package center - flexget 은 beta 라서 설치해주는것은 별로고,  
내부 리눅스에 설치하기엔 python 설치하기부터 귀찮음.
  - docker 사용으로 결정
- official docker hub 가 있는가?
  - 없음
  - official repository 에 dockerfile 은 있음. 적절한 docker hub repo 못찾으면 직접빌드하기로함.  
https://github.com/Flexget/Flexget/blob/develop/Dockerfile
  - docker hub 내에서 flexget 검색하고, Recently updated 로 정렬한뒤,  
tag 에 최신버전(2020-08-14 기준 3.1.67)이 있나 확인함.  
참고: flexget 최신버전확인 - https://github.com/Flexget/Flexget/releases  
참고2: 찾은 docker hub repo tag 리스트 - https://hub.docker.com/r/wiserain/flexget/tags
  - https://hub.docker.com/r/wiserain/flexget 로 정했고,  
링크로 연결된 Github Source Repository 접속해서 사용법확인  
https://github.com/wiserain/docker-flexget
```bash
# timezone 동작하는지 체크
# https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
docker run --rm -it \
    --entrypoint /bin/bash \
    -e TZ=Asia/Seoul \
    wiserain/flexget:3.1.67 -ce date
> Fri Aug 14 03:27:17 KST 2020


# uid 체크
$ echo $UID

# gid 체크
$ cat /etc/group | grep $(whoami)
> administrators:x:101:admin,<USERNAME>
> docker:x:65538:<USERNAME>

# 아... 필요한 소유자, 그룹은 transmission 것과 같으면될듯 
$ ls -alh /volume1/downloads/transmissions/Complete
drwxrwxrwx+ 1 <USERNAME>           users         538 Aug 13 23:53 .
drwxrwxrwx+ 1 <USERNAME>           users          76 Mar  8 03:57 ..
drwxrwxrwx+ 1 <USERNAME>           users         124 Mar 23 00:11 실리콘밸리
-rwxrwxrwx+ 1 <USERNAME>           users        6.1K Mar 23 00:11 .DS_Store
-rwxrwxrwx+ 1 sc-transmission transmission 1.9G Apr  1 19:52 부부의 세계.E01.200327.720p-NEXT.mp4
drwxrwxrwx+ 1 sc-transmission transmission  114 Aug  8 17:52 악의꽃.E01.200729.720p-NEXT
-rwxrwxrwx+ 1 sc-transmission transmission 1.8G Apr  1 19:54 부부의 세계.E02.200328.720p-NEXT.mp4
drwxrwxrwx+ 1 sc-transmission transmission  114 Aug  8 17:52 악의꽃.E02.200730.720p-NEXT
drwxrwxrwx+ 1 sc-transmission transmission  114 Aug  8 17:52 악의 꽃.E03.200805.720p-NEXT
drwxrwxrwx+ 1 sc-transmission transmission  116 Aug  8 17:53 악의 꽃.E04.200806.720p-NEXT
-rwxrwxrwx+ 1 sc-transmission transmission 1.5G Aug 13 23:53 악의 꽃.E05.200812.720p-NEXT.mp4
drwxrwxrwx+ 1 root            users         208 Aug  8 17:52 @eaDir

# ?.. user: <USERNAME>, group: users 로 정함
$ cat /etc/group | grep users
users:x:100:


cd /volume1/downloads
mkdir -p flexget/data
mkdir -p flexget/config

docker run -d \
    --restart=always \
    --name=flexget \
    -p 5050:5050 \
    -v /volume1/downloads/flexget/data:/data \
    -v /volume1/downloads/flexget/config:/config \
    -e FG_WEBUI_PASSWD=<desired password> \
    -e PUID=$UID \
    -e PGID=100 \
    -e TZ=Asia/Seoul \
    wiserain/flexget:3.1.67
```
