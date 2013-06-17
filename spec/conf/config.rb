require 'configatron'


# ip address is only needed if it is a real rtsp connection
# the client will default to port 554
#
#woza rtsp ec2 server
configatron.rtsp_server_wowza.url='184.72.239.149'
configatron.fake_rtsp_server.url='http://localhost'

