import time 
import sys
import stomp

class Listener(stomp.ConnectionListener):
    def on_error(self, headers, message):
        print('received an error "%s"' % message)  

    def on_message(self, headers, message):
        print('received a message "%s"' % message)

hosts = [('localhost', 61613)] 
conn = stomp.StompConnection10(host_and_ports=hosts)
conn.set_listener('', Listener())
#conn.start()
conn.connect('admin', 'admin', wait=True)# Register a subscriber with ActiveMQ. This tells ActiveMQ to send
# all messages received on the topic 'topic-1' to this listenerconn.subscribe(destination='/topic/topic-1', ack='auto') # Act as a message publisher and send a message the queue queue-1conn.send(body=' '.join(sys.argv[1:]), destination='/topic/topic-1')
time.sleep(2)
conn.disconnect()