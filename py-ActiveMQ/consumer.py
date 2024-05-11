import stomp

class MsgListener(stomp.ConnectionListener):
    def __init__(self):
        # to keep the count of messages received
        self.msg_recieved = 0

    def on_error(self, message):
        logger.error('received an error "%s"' %message)

    def on_message(self, message):
        message = json.loads(message)
        self.msg_received +=1
        # add your logic based on the message received here

#Establish a connection
con = stomp.StompConnection10([('192.168.100.5', 61613)])
#listener class to be instantiated.
listener = MsgListener()
con.set_listener('saeed', listener)
#wait will ensure it waits till connection is established and acknowledged.
con.connect('admin', 'admin', wait=True)
#subscribe to a particular topic or queue by giving the path and headers if required by the server.
con.subscribe('rnd-queue', headers={})