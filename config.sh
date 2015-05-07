#!/bin/bash
logstash agent -e "input {stdin{}} output{stdout{}}"