#!/usr/bin/python
import serial
import subprocess
import time

port = serial.Serial("/dev/ttyS3", 460800, timeout=1)

open('received.txt', 'w').close()

time.sleep(1)

command = ['/oc/bin/api/zmq_client', 'registers', 'user_name', 'g', 'payload_off_pending']

out = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
stdout,stderr = out.communicate()

while stdout.decode() == 'payload_off_pending 0\n':
	out = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
	stdout,stderr = out.communicate()
	file = open("received.txt", 'ab')
	file.write(port.read(512))
	file.close()

port.close()

command = ['/oc/bin/api/zmq_client', 'power', 'user', 'p', '5v0', '0']
out = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
stdout,stderr = out.communicate()
