#!/bin/bash
echo $BOB
logstash agent -e "input {stdin{}} output{stdout{}}"