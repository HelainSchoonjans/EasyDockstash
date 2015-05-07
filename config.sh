#!/bin/bash
# @author heschoon
# this script launch logstash, with log4j as input and rabbitmq as output.
# the parameters are comes from the environment variables or use default values

#LOG4J STUFF
if [ -z $LOG4J_ADD_FIELD ];
then
	LOG4J_ADD_FIELD="{}"
fi
if [ -z $LOG4J_CODEC ];
then
	LOG4J_CODEC="\"plain\""
fi
if [ -z $LOG4J_DATA_TIMEOUT ];
then
	LOG4J_DATA_TIMEOUT="5"
fi
if [ -z $LOG4J_HOST ];
then
	LOG4J_HOST="\"0.0.0.0\""
fi
if [ -z $LOG4J_MODE ];
then
	LOG4J_MODE="\"server\""
fi
if [ -z $LOG4J_PORT ];
then
	LOG4J_PORT="4560"
fi




#RABBITMQ STUFF
if [ -z $RABBITMQ_CODEC ];
then
	RABBITMQ_CODEC="\"plain\""
fi
if [ -z $RABBITMQ_DURABLE ];
then
	RABBITMQ_DURABLE="true"
fi
if [ -z $RABBITMQ_EXCHANGE ];
then
	echo "RABBITMQ_EXCHANGE missing"
	exit 1
fi
if [ -z $RABBITMQ_EXCHANGE_TYPE ];
then
	echo "RABBITMQ_EXCHANGE_TYPE missing"
	exit 1
fi
if [ -z $RABBITMQ_HOST ];
then
	echo "RABBITMQ_HOST missing"
	exit 1
fi
if [ -z $RABBITMQ_KEY ];
then
	RABBITMQ_KEY="\"logstash\"" # should be changed
fi
if [ -z $RABBITMQ_PASSWORD ];
then
	RABBITMQ_PASSWORD="\"guest\"" # should be changed
fi
if [ -z $RABBITMQ_PERSISTENT ];
then
	RABBITMQ_PERSISTENT="true"
fi
if [ -z $RABBITMQ_PORT ];
then
	RABBITMQ_PORT="5672"
fi
if [ -z $RABBITMQ_SSL ];
then
	RABBITMQ_SSL="false"
fi
if [ -z $RABBITMQ_USER ];
then
	RABBITMQ_USER="\"guest\"" #should be changed
fi
if [ -z $RABBITMQ_VERIFY_SSL ];
then
	RABBITMQ_VERIFY_SSL="false"
fi
if [ -z $RABBITMQ_VHOST ];
then
	RABBITMQ_VHOST="\"/\""
fi
if [ -z $RABBITMQ_WORKERS ];
then
	RABBITMQ_WORKERS="1"
fi

echo "\
input {\
	   log4j {\
		add_field => $LOG4J_ADD_FIELD # hash (optional), default: {}\
		codec => $LOG4J_CODEC # codec (optional), default: \"plain\"\
		data_timeout => $LOG4J_DATA_TIMEOUT # number (optional), default: 5\
		host => $LOG4J_HOST # string (optional), default: \"0.0.0.0\"\
		mode => $LOG4J_MODE # string, one of [\"server\", \"client\"] (optional), default: \"server\"\
		port => $LOG4J_PORT # number (optional), default: 4560\
	}\
}\
output{\
    stdout{\
	    rabbitmq {\
			codec => $RABBITMQ_CODEC # codec (optional), default: \"plain\"\
			durable => $RABBITMQ_DURABLE # boolean (optional), default: true\
			exchange => $RABBITMQ_EXCHANGE # string (required)\
			exchange_type => $RABBITMQ_EXCHANGE_TYPE # string, one of [\"fanout\", \"direct\", \"topic\"] (required)\
			host => $RABBITMQ_HOST # string (required)\
			key => $RABBITMQ_KEY # string (optional), default: \"logstash\"\
			password => $RABBITMQ_PASSWORD # password (optional), default: \"guest\"\
			persistent => $RABBITMQ_PERSISTENT # boolean (optional), default: true\
			port => $RABBITMQ_PORT # number (optional), default: 5672\
			ssl => $RABBITMQ_SSL # boolean (optional), default: false\
			user => $RABBITMQ_USER # string (optional), default: \"guest\"\
			verify_ssl => $RABBITMQ_VERIFY_SSL # boolean (optional), default: false\
			vhost => $RABBITMQ_VHOST # string (optional), default: \"/\"\
			workers => $RABBITMQ_WORKERS # number (optional), default: 1\
		}\
	}\
}"
logstash agent -e "\
input {\
	   log4j {\
		add_field => $LOG4J_ADD_FIELD # hash (optional), default: {}\
		codec => $LOG4J_CODEC # codec (optional), default: \"plain\"\
		data_timeout => $LOG4J_DATA_TIMEOUT # number (optional), default: 5\
		host => $LOG4J_HOST # string (optional), default: \"0.0.0.0\"\
		mode => $LOG4J_MODE # string, one of [\"server\", \"client\"] (optional), default: \"server\"\
		port => $LOG4J_PORT # number (optional), default: 4560\
	}\
}\
output{\
	rabbitmq {\
		codec => $RABBITMQ_CODEC # codec (optional), default: \"plain\"\
		durable => $RABBITMQ_DURABLE # boolean (optional), default: true\
		exchange => $RABBITMQ_EXCHANGE # string (required)\
		exchange_type => $RABBITMQ_EXCHANGE_TYPE # string, one of [\"fanout\", \"direct\", \"topic\"] (required)\
		host => $RABBITMQ_HOST # string (required)\
		key => $RABBITMQ_KEY # string (optional), default: \"logstash\"\
		password => $RABBITMQ_PASSWORD # password (optional), default: \"guest\"\
		persistent => $RABBITMQ_PERSISTENT # boolean (optional), default: true\
		port => $RABBITMQ_PORT # number (optional), default: 5672\
		ssl => $RABBITMQ_SSL # boolean (optional), default: false\
		user => $RABBITMQ_USER # string (optional), default: \"guest\"\
		verify_ssl => $RABBITMQ_VERIFY_SSL # boolean (optional), default: false\
		vhost => $RABBITMQ_VHOST # string (optional), default: \"/\"\
		workers => $RABBITMQ_WORKERS # number (optional), default: 1\
	}\
}"