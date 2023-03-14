First off you'll need to compile handler.c into handler. This can simply be done with the command "gcc handler.c -o handler"

Then you will need to set some directories in the code. In Pari, there is a system call which calls the binary handler which you just compiled. This is in the Shintani code and will need to be changed to whatever directory you have all these files in.

Also in Pari, note that in the Shintani function, there are write/reads/rm calls to a directory. This is where the code stores temporary file to communicate with Sage, and Pari currently uses the directory /tmp/integral_points. This can be changed if needed, but will need to be changed in Sage also.

To run the code, all the files (Pari, Sage, and compiled handler) need to be in the same directory. First run the sage point coutner script, then read and execture the Pari code with rossi(pol, s), where s >= 0.

