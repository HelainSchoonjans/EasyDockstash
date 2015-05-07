#!/bin/bash















LOG4J_ADD_FIELD = "{}"
LOG4J_CODEC = "plain"
LOG4J_DATA_TIMEOUT = "5"
LOG4J_HOST = "0.0.0.0"
LOG4J_MODE = "server"
LOG4J_PORT = "4560"
LOG4J_TAGS = 
LOG4J_TYPE =

RABBITMQ_CODEC = "plain"
RABBITMQ_DURABLE = "true"
RABBITMQ_EXCHANGE = #R
RABBITMQ_EXCHANGE_TYPE = #R
RABBITMQ_HOST = #R
RABBITMQ_KEY = "logstash" # should be changed
RABBITMQ_PASSWORD = "guest" # should be changed
RABBITMQ_PERSISTENT = "true"
RABBITMQ_PORT = "5672"
RABBITMQ_SSL = "false"
RABBITMQ_USER = "guest" #should be changed
RABBITMQ_VERIFY_SSL = "false"
RABBITMQ_VHOST = "/"
RABBITMQ_WORKERS = "1"

INPUT_START = "\
input {\
    stdin{\
	    log4j {\
"

MIDDLE_STUFF = "	}\
}\
output{\
    stdout{\
	    rabbitmq {\
"

OUTPUT_END = "		}\
	}\
}"






LOG4J_ADD_FIELD = "add_field => $LOG4J_ADD_FIELD # hash (optional), default: {}"
LOG4J_CODEC = "codec => $LOG4J_CODEC # codec (optional), default: \"plain\""
LOG4J_DATA_TIMEOUT = "data_timeout => $LOG4J_DATA_TIMEOUT # number (optional), default: 5"
LOG4J_HOST = "0.0.0.0"
LOG4J_MODE = "server"
LOG4J_PORT = "4560"
LOG4J_TAGS = 
LOG4J_TYPE =


logstash agent -e "\
input {\
	   log4j {\
		$LOG4J_ADD_FIELD\
		$LOG4J_CODEC\
		data_timeout => $LOG4J_DATA_TIMEOUT # number (optional), default: 5\
		host => $LOG4J_HOST # string (optional), default: \"0.0.0.0\"\
		mode => $LOG4J_MODE # string, one of [\"server\", \"client\"] (optional), default: \"server\"\
		port => $LOG4J_PORT # number (optional), default: 4560\
		tags => $LOG4J_TAGS # array (optional)\
		type => $LOG4J_TYPE # string (optional)\
	}\
}\
output{\
    stdout{\
	    rabbitmq {\
			codec => $RABBITMQ_CODEC # codec (optional), default: \"plain\"\
			durable => $RABBITMQ_DURABLE # boolean (optional), default: true\
			exchange => $RABBITMQ_EXCHANGE # string (required)\
			exchange_type => $RABBITMQ_EXCHANGE_TYPE # string, one of [\"fanout\", \"direct\", \"topic\"] (required) <
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
		tags => $LOG4J_TAGS # array (optional)\
		type => $LOG4J_TYPE # string (optional)\
	}\
}\
output{\
    stdout{\
	    rabbitmq {\
			codec => $RABBITMQ_CODEC # codec (optional), default: \"plain\"\
			durable => $RABBITMQ_DURABLE # boolean (optional), default: true\
			exchange => $RABBITMQ_EXCHANGE # string (required)\
			exchange_type => $RABBITMQ_EXCHANGE_TYPE # string, one of [\"fanout\", \"direct\", \"topic\"] (required) <
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