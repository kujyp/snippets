#!/usr/bin/env bash


(
cd generated/dockerfiles/registry.navercorp.com/mtengine/cuda_base
docker_tag=registry.navercorp.com/mtengine/cuda_base:cuda10.0_cudnn7.3
docker -H 10.116.70.141:4243 build -t ${docker_tag} -f Dockerfile.cuda10.0_cudnn7.3 .
)


(
cd generated/dockerfiles/registry.navercorp.com/mtengine/cuda_python_base
docker_tag=registry.navercorp.com/mtengine/cuda_python_base:cuda10.0_cudnn7.3_python3.6.7
docker -H 10.116.70.141:4243 build -t ${docker_tag} -f Dockerfile.cuda10.0_cudnn7.3_python3.6.7 .
)

(
cd dockerfiles/registry.navercorp.com/mtengine/horovod
docker_tag=registry.navercorp.com/mtengine/horovod:cuda10.0_cudnn7.3_python3.6.7_tf1.14.0
docker -H 10.116.70.141:4243 build -t ${docker_tag} -f Dockerfile.cuda10.0_cudnn7.3_python3.6.7_tf1.14.0 .
)

docker -H 10.116.70.141:4243 run --privileged -it --rm ${docker_tag}
