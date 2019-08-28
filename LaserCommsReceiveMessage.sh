#!/bin/bash

# power up
cd /oc/bin/api
./zmq_client power user p 5v0 0
./zmq_client registers user s payload_off_pending 0
./zmq_client power user p 5v0 1

./zmq_client leds user s 0 0
./zmq_client leds user s 1 0
./zmq_client leds user s 2 0
./zmq_client leds user s 3 0
./zmq_client leds user s 4 0

sleep 1

cd /home/OC_demos
python LaserCommsReceiveMessage.py

cd /oc/bin/api
./zmq_client leds user s 0 1
./zmq_client leds user s 1 1
./zmq_client leds user s 2 1
./zmq_client leds user s 3 1
./zmq_client leds user s 4 1

kill $(jobs -p)
