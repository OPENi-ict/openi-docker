#!/bin/sh

source conf

#                 Container                                                                               Image
docker run -d --name openicb -v $CB_OUTPUT_PATH:$CB_PATH -p 9200:9200  -p 443:443 -p 80:80 -p 8091:8091  openiicteu/couchbase
sleep 60
docker run -d --name openidao_proxy                                  --net=container:openicb   openiicteu/dao_proxy
sleep 4
docker run -d --name openies                                         --net=container:openicb   openiicteu/elasticsearch
docker run -d --name openinotifications  -v $OUTPUT_PATH:$C_LOG_PATH --net=container:openicb   openiicteu/notifications
docker run -d --name openiauthapi        -v $OUTPUT_PATH:$C_LOG_PATH --net=container:openicb   openiicteu/authapi
docker run -d --name openiattachmentapi  -v $OUTPUT_PATH:$C_LOG_PATH --net=container:openicb   openiicteu/attachmentapi
docker run -d --name openiobjectapi      -v $OUTPUT_PATH:$C_LOG_PATH --net=container:openicb   openiicteu/objectapi
docker run -d --name openipermissionsapi -v $OUTPUT_PATH:$C_LOG_PATH --net=container:openicb   openiicteu/permissionsapi
docker run -d --name openiswagger        -v $OUTPUT_PATH:$C_LOG_PATH --net=container:openicb   openiicteu/swaggerdef
docker run -d --name openicloudletapi    -v $OUTPUT_PATH:$C_LOG_PATH --net=container:openicb   openiicteu/cloudletapi
docker run -d --name openisearchapi      -v $OUTPUT_PATH:$C_LOG_PATH --net=container:openicb   openiicteu/searchapi
docker run -d --name openitypeapi        -v $OUTPUT_PATH:$C_LOG_PATH --net=container:openicb   openiicteu/typeapi
docker run -d --name openihttpswagger    -v $OUTPUT_PATH:$C_LOG_PATH --net=container:openicb   openiicteu/httpswaggerdef
docker run -d --name openiredirect                                   --net=container:openicb   openiicteu/redirect
docker run -d --name openiadmindash                                  --net=container:openicb   openiicteu/admin-dashboard
docker run -d --name openiuserdash                                   --net=container:openicb   openiicteu/user-dashboard
docker run -d --name openiauthdialogs                                --net=container:openicb   openiicteu/auth-dialogs
docker run -d --name openidao            -v $OUTPUT_PATH:$C_LOG_PATH --net=container:openicb   openiicteu/dao
docker run -d --name openimongrel2       -v $OUTPUT_PATH:$M_LOG_PATH --net=container:openicb   openiicteu/mongrel2

docker run -i --name openidao            -v /opt/openi/docker/logs/:/opt/openi/cloudlet_platform/logs --net=container:openicb   openiicteu/dao


