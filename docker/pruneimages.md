
```bash
docker images | grep '23..GB' | grep '<none>                                                   <none>'
docker images | grep '23..GB' | grep '<none>                                                   <none>' | awk '{ print $3 }'
docker rmi $(docker images | grep '23..GB' | grep '<none>                                                   <none>' | awk '{ print $3 }')
```

```bash
$ docker images | grep '<none>                                                   <none>'
<none>                                                   <none>                                                                                                                  6ce15bfd9e9a        5 months ago         19.5GB
<none>                                                   <none>                                                                                                                  3d59d0358203        5 months ago         19.5GB
<none>                                                   <none>                                                                                                                  07dc9d4713bf        5 months ago         19.4GB
<none>                                                   <none>                                                                                                                  4ac49f51f6c7        5 months ago         19.4GB
<none>                                                   <none>                                                                                                                  2ff304b8d3e6        5 months ago         19.4GB
<none>                                                   <none>                                                                                                                  bf2c7b90e0cc        5 months ago         19.4GB
<none>                                                   <none>                                                                                                                  86842699b637        5 months ago         19.4GB
<none>                                                   <none>                                                                                                                  ef72c844ee90        5 months ago         19.4GB
<none>                                                   <none>                                                                                                                  2943cd53a85b        5 months ago         19.4GB
<none>                                                   <none>                                                                                                                  1aa78ac1ea55        5 months ago         19.4GB
<none>                                                   <none>                                                                                                                  8d396a26e1a0        5 months ago         19.4GB
<none>                                                   <none>                                                                                                                  9e04f3174ac6        5 months ago         19.4GB
<none>                                                   <none>                                                                                                                  3fd0e1876af8        5 months ago         19.4GB
<none>                                                   <none>                                                                                                                  74525bfe62fe        5 months ago         19.4GB

$ docker images > /tmp/docker_images_all.txt
$ cat /tmp/docker_images_all.txt | grep '<none>                                                   <none>' | grep 'hours'
$ cat /tmp/docker_images_all.txt | grep '<none>                                                   <none>' | grep 'minutes'
% cat /tmp/docker_images_all.txt | grep '<none>                                                   <none>' | grep -v 'months ago' | grep -v 'weeks ago'
<none>                                                   <none>                                                                                                                  26e984afb86b        21 seconds ago      7.52GB
<none>                                                   <none>                                                                                                                  7dfe61ff24fa        13 hours ago        14.3GB
<none>                                                   <none>                                                                                                                  ba26d3ed1672        14 hours ago        15.4GB
<none>                                                   <none>                                                                                                                  de9e95d3b0f9        15 hours ago        17.9GB
<none>                                                   <none>                                                                                                                  46799e6ead8a        38 hours ago        2.48GB
<none>                                                   <none>                                                                                                                  d34ab6aa7906        4 days ago          14GB
<none>                                                   <none>                                                                                                                  858dc3e3c984        4 days ago          14GB
<none>                                                   <none>                                                                                                                  a1491a33a232        4 days ago          9.35GB
<none>                                                   <none>                                                                                                                  b9cab4fa40ec        8 days ago          9.5GB


cat /tmp/docker_images_all.txt | grep '<none>                                                   <none>' | grep 'second'
cat /tmp/docker_images_all.txt | grep '<none>                                                   <none>' | grep 'minute'
cat /tmp/docker_images_all.txt | grep '<none>                                                   <none>' | grep 'hour'
cat /tmp/docker_images_all.txt | grep '<none>                                                   <none>' | grep 'day'
cat /tmp/docker_images_all.txt | grep '<none>                                                   <none>' | grep 'week'
cat /tmp/docker_images_all.txt | grep '<none>                                                   <none>' | grep 'month'
docker images | grep '<none>                                                   <none>' | grep 'month'
docker rmi $(docker images | grep '<none>                                                   <none>' | grep 'month' | awk '{ print $3 }'))
```
