#!/bin/bash

# https://kubernetes.io/docs/reference/kubectl/jsonpath/
kubectl get service job-gpu-swe-jaeyoungpark-190910232917 -o=jsonpath='{.status.loadBalancer.ingress[0].ip}'
kubectl get service job-gpu-swe-jaeyoungpark-190910232917 -o=jsonpath='{.spec.ports[*].port}'
kubectl get service job-gpu-swe-jaeyoungpark-190910232917 -o=jsonpath='{range .spec.ports[*]}{.name} {.port}{"\n"}{end}'
kubectl exec -it $(kubectl get pod -l job-name=job-gpu-swe-jaeyoungpark-190910232917 --no-headers | awk '{ print $1 }') bash

#map[
#    apiVersion:v1
#    kind:Service
#    metadata:map[
#        creationTimestamp:2019-09-10T14:29:19Z
#        name:job-gpu-swe-jaeyoungpark-190910232917
#        namespace:mtengine
#        resourceVersion:26803443
#        selfLink:/api/v1/namespaces/mtengine/services/job-gpu-swe-jaeyoungpark-190910232917
#        uid:5fccd3d7-d3d7-11e9-942f-9241d0f9cebd
#    ]
#    spec:map[
#        clusterIP:172.24.55.125
#        externalTrafficPolicy:Cluster
#        ports:[
#            map[name:http nodePort:31820 port:80 protocol:TCP targetPort:80]
#            map[name:https nodePort:31386 port:443 protocol:TCP targetPort:443]
#            map[name:rsync nodePort:30898 port:873 protocol:TCP targetPort:873]
#            map[name:tensorboard nodePort:31761 port:6006 protocol:TCP targetPort:6006]
#            map[name:wellknown1 nodePort:30303 port:8000 protocol:TCP targetPort:8000]
#            map[name:wellknown2 nodePort:30973 port:8001 protocol:TCP targetPort:8001]
#            map[name:wellknown3 nodePort:31661 port:8002 protocol:TCP targetPort:8002]
#            map[name:wellknown4 nodePort:31340 port:8080 protocol:TCP targetPort:8080]
#            map[name:jupyter nodePort:32376 port:8888 protocol:TCP targetPort:8888]
#            map[name:papago nodePort:32710 port:8895 protocol:TCP targetPort:8895]
#        ]
#        selector:map[
#            resource_name:job-gpu-swe-jaeyoungpark-190910232917
#        ]
#        sessionAffinity:None
#        type:LoadBalancer
#    ]
#    status:map[
#        loadBalancer:map[
#            ingress:[
#                map[
#                    ip:10.113.152.40
#                ]
#            ]
#        ]
#    ]
#]
