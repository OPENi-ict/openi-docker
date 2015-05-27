#!/usr/bin/env bash

#add default ports to config


source conf

#                 Container                                                                               Image
docker run -d --name openicb        -v $COUCHBASE_DATA_PATH:/opt/couchbase/var/lib/couchbase/ -p 80:80 -p 443:443 -p 9200:9200 -p 8091:8091 -p 8092:8092 openiicteu/couchbase
sleep 30
docker run -d --name openies                                         --net=container:openicb	openiicteu/elasticsearch

dao_proxy=$( cat cloudlet_platform/conf.json | ./json.sh -p | egrep '\["dao_proxy"*"\]' | sed -e 's/\[\"dao_proxy\"\]//g')
docker run -d --name openidao_proxy                                                           --net=container:openicb  openiicteu/cloudlet_platform 	-w dao_proxy            -c $dao_proxy
sleep 4

dao=$( cat cloudlet_platform/conf.json | ./json.sh -p | egrep '\["dao"*"\]' | sed -e 's/\[\"dao\"\]//g')
docker run -d --name dao_1    -v $LOG_OUTPUT_PATH_ROOT:/opt/openi/cloudlet_platform/logs/     --net=container:openicb	openiicteu/cloudlet_platform 	-w dao                  -c $dao
docker run -d --name dao_2    -v $LOG_OUTPUT_PATH_ROOT:/opt/openi/cloudlet_platform/logs/     --net=container:openicb	openiicteu/cloudlet_platform 	-w dao                  -c $dao
docker run -d --name dao_3    -v $LOG_OUTPUT_PATH_ROOT:/opt/openi/cloudlet_platform/logs/     --net=container:openicb	openiicteu/cloudlet_platform 	-w dao                  -c $dao


swagger_def_https=$( cat cloudlet_platform/conf.json | ./json.sh -p | egrep '\["swagger_def_https"*"\]' | sed -e 's/\[\"swagger_def_https\"\]//g')
docker run -d --name swagger_def_https  -v $LOG_OUTPUT_PATH_ROOT:/opt/openi/cloudlet_platform/logs/ --net=container:openicb openiicteu/cloudlet_platform    -w swagger_def      -c $swagger_def_https

swagger_def_http=$( cat cloudlet_platform/conf.json | ./json.sh -p | egrep '\["swagger_def_http"*"\]' | sed -e 's/\[\"swagger_def_http\"\]//g')
docker run -d --name swagger_def_http   -v $LOG_OUTPUT_PATH_ROOT:/opt/openi/cloudlet_platform/logs/ --net=container:openicb openiicteu/cloudlet_platform 	-w swagger_def      -c $swagger_def_http

type_api=$( cat cloudlet_platform/conf.json | ./json.sh -p | egrep '\["type_api"*"\]' | sed -e 's/\[\"type_api\"\]//g')
docker run -d --name type_api         -v $LOG_OUTPUT_PATH_ROOT:/opt/openi/cloudlet_platform/logs/   --net=container:openicb openiicteu/cloudlet_platform    -w type_api         -c $type_api

object_api=$( cat cloudlet_platform/conf.json | ./json.sh -p | egrep '\["object_api"*"\]' | sed -e 's/\[\"object_api\"\]//g')
docker run -d --name object_api       -v $LOG_OUTPUT_PATH_ROOT:/opt/openi/cloudlet_platform/logs/   --net=container:openicb openiicteu/cloudlet_platform 	-w object_api       -c $object_api

cloudlet_api=$( cat cloudlet_platform/conf.json | ./json.sh -p | egrep '\["cloudlet_api"*"\]' | sed -e 's/\[\"cloudlet_api\"\]//g')
docker run -d --name cloudlet_api     -v $LOG_OUTPUT_PATH_ROOT:/opt/openi/cloudlet_platform/logs/   --net=container:openicb	openiicteu/cloudlet_platform 	-w cloudlet_api     -c $cloudlet_api

attachments_api=$( cat cloudlet_platform/conf.json | ./json.sh -p | egrep '\["attachments_api"*"\]' | sed -e 's/\[\"attachments_api\"\]//g')
docker run -d --name attachments_api  -v $LOG_OUTPUT_PATH_ROOT:/opt/openi/cloudlet_platform/logs/   --net=container:openicb	openiicteu/cloudlet_platform 	-w attachments_api  -c $attachments_api

search_api=$( cat cloudlet_platform/conf.json | ./json.sh -p | egrep '\["search_api"*"\]' | sed -e 's/\[\"search_api\"\]//g')
docker run -d --name search_api       -v $LOG_OUTPUT_PATH_ROOT:/opt/openi/cloudlet_platform/logs/   --net=container:openicb	openiicteu/cloudlet_platform 	-w search_api       -c $search_api

permissions_api=$( cat cloudlet_platform/conf.json | ./json.sh -p | egrep '\["permissions_api"*"\]' | sed -e 's/\[\"permissions_api\"\]//g')
docker run -d --name permissions_api  -v $LOG_OUTPUT_PATH_ROOT:/opt/openi/cloudlet_platform/logs/   --net=container:openicb	openiicteu/cloudlet_platform 	-w permissions_api  -c $permissions_api

notifications=$( cat cloudlet_platform/conf.json | ./json.sh -p | egrep '\["notifications"*"\]' | sed -e 's/\[\"notifications\"\]//g')
docker run -d --name notifications    -v $LOG_OUTPUT_PATH_ROOT:/opt/openi/cloudlet_platform/logs/   --net=container:openicb	openiicteu/cloudlet_platform 	-w notifications    -c $notifications

auth_api=$( cat cloudlet_platform/conf.json | ./json.sh -p | egrep '\["auth_api"*"\]' | sed -e 's/\[\"auth_api\"\]//g')
docker run -d --name auth_api         -v $LOG_OUTPUT_PATH_ROOT:/opt/openi/cloudlet_platform/logs/   --net=container:openicb	openiicteu/cloudlet_platform 	-w auth_api         -c $auth_api

crud_api=$( cat cloudlet_platform/conf.json | ./json.sh -p | egrep '\["crud_api"*"\]' | sed -e 's/\[\"crud_api\"\]//g')
docker run -d --name crud_api         -v $LOG_OUTPUT_PATH_ROOT:/opt/openi/cloudlet_platform/logs/   --net=container:openicb	openiicteu/cloudlet_platform 	-w crud_api         -c $crud_api

openi_rrd=$( cat cloudlet_platform/conf.json | ./json.sh -p | egrep '\["openi_rrd"*"\]' | sed -e 's/\[\"openi_rrd\"\]//g')
docker run -d --name openi_rrd        -v $LOG_OUTPUT_PATH_ROOT:/opt/openi/cloudlet_platform/logs/   --net=container:openicb	openiicteu/cloudlet_platform 	-w openi_rrd        -c $openi_rrd

https_redirect=$( cat cloudlet_platform/conf.json | ./json.sh -p | egrep '\["https_redirect"*"\]' | sed -e 's/\[\"https_redirect\"\]//g')
docker run -d --name https_redirect   -v $LOG_OUTPUT_PATH_ROOT:/opt/openi/cloudlet_platform/logs/   --net=container:openicb	openiicteu/cloudlet_platform 	-w https_redirect   -c $https_redirect

openi_aggregator=$( cat cloudlet_platform/conf.json | ./json.sh -p | egrep '\["openi_aggregator"*"\]' | sed -e 's/\[\"openi_aggregator\"\]//g')
docker run -d --name openi_aggregator -v $LOG_OUTPUT_PATH_ROOT:/opt/openi/cloudlet_platform/logs/   --net=container:openicb	openiicteu/cloudlet_platform 	-w openi_aggregator -c $openi_aggregator


docker run -d --name openiadmindash                                                                 --net=container:openicb	openiicteu/admin-dashboard
docker run -d --name openiuserdash                                                                  --net=container:openicb	openiicteu/user-dashboard
docker run -d --name openiauthdialogs                                                               --net=container:openicb	openiicteu/auth-dialogs

docker run -d --name openimongrel2  -v $LOG_OUTPUT_PATH_ROOT:/mongrel2/logs/                        --net=container:openicb	openiicteu/mongrel2

#docker run -d --name xyz                                  --net=container:openicb	openiicteu/cloudlet_platform 	-w xyz -c ""

