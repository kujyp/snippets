
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
```
