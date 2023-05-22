# import socket programming library
import socket

import sys
import time


def calculate_points(ext):

    #This directory should be the same in pari
    f = open('/tmp/integral_points/' + ext, 'r')
    
    
    data = f.read()
    
    data = data.split('\n')
    print(data)

    f.close()

    v1 = eval(data[0][:-1].replace("[", "(").replace("]", ")"))
    v2 = eval(data[1][:-1].replace("[", "(").replace("]", ")"))
    v3 = eval(data[2][:-1].replace("[", "(").replace("]", ")"))

    P = Polyhedron(vertices=[(0,0,0), v1, v2, v3, 
        (v1[0] + v2[0], v1[1] + v2[1], v1[2] + v2[2]),
        (v1[0] + v3[0], v1[1] + v3[1], v1[2] + v3[2]),
        (v2[0] + v3[0], v2[1] + v3[1], v2[2] + v3[2]),
        (v1[0] + v2[0] + v3[0], v1[1] + v2[1] + v3[1], v1[2] + v2[2] + v3[2]),
    ])
    points = P.integral_points()


    #This directory needs to be the same as the one used in pari
    f = open('/tmp/integral_points/' + ext, 'w')
    
    f.write(str(pari(points)))      
    f.close()



def Main():
    host = "127.0.0.1"

    # reserve a port on your computer
    # in our case it is 12345 but it
    # can be anything
    port = 12345
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.bind((host, port))
    print("socket binded to port", port)

    # put the socket into listening mode
    s.listen(1)
    print("socket is listening")

    # a forever loop until client wants to exit
    while True:

        # establish connection with client
        c, addr = s.accept()

        data = c.recv(1024)

        if not data:
            print('Bye')
            break

        calculate_points(data.decode())

        # connection closed
        c.close()
        
    s.close()


if __name__ == '__main__':
	Main()
