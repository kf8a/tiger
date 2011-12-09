#To set up a reverse proxy to allow the NIS to get at files
#on my machine to retrieve data
ssh  -f -N -q -R '*':9999:localhost:8080 gprpc32.kbs.msu.edu
