#!/bin/bash

# power up
cd /oc/bin/api
./zmq_client power user p 5v0 0
sleep 1
./zmq_client power user p 5v0 1
./zmq_client registers user s payload_off_pending 0

./zmq_client leds user i 0
./zmq_client leds user s 0 1
./zmq_client leds user s 1 0
./zmq_client leds user s 2 0
./zmq_client leds user s 3 0
./zmq_client leds user s 4 0

sleep 1

stty -F /dev/ttyS3 460800

./zmq_client leds user s 1 1

sleep 1

while [ "$(expr index "$(./zmq_client registers user_name g payload_off_pending)" "1")" != "21" ]
do
  ./zmq_client power user p 5v0 0
  sleep 1
  ./zmq_client power user p 5v0 1
  sleep 3
  echo "This is a test message to be sent over optical link.\n" > /dev/ttyS3
  sleep 12
done

./zmq_client leds user s 0 0
./zmq_client leds user s 1 0
./zmq_client power user p 5v0 0

kill $(jobs -p)
