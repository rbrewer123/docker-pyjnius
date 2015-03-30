##############################
Pyjnius Docker Appliance
##############################

Purpose
###########

This ``Dockerfile`` creates a simple docker-based environment for
doing desktop development with Oracle Java 9 and pyjnius based on
Ubuntu 14.04.


Requirements
################

This is tested with docker 1.5.0 running on Ubuntu 14.04.  Since it's
main dependency is docker, it should run on any platform with docker
installed (e.g. Windows, OS X).  It may or may not work with earlier
versions of docker.  To install docker on your system, see the
official `docker installation instructions
<https://docs.docker.com/installation>`_.



Installation
##############

To build the docker image::

  $ docker build -t user/pyjnius github.com/rbrewer123/docker-pyjnius

You should replace ``user`` with your own username in all of these
instructions.  You can see your new image with this command::

  $ docker images


Run
#######

To get a root shell inside the container, do this::

  $ docker run --rm -it user/pyjnius 

The recommended way to run the container is as your own user. 
The container has a built-in script ``runasuser.sh`` to facilitate this.
To see help on ``runasuser.sh``, simply pass the ``-h`` flag to the container::

  $ docker run --rm -it user/pyjnius -h

To run the java compiler inside the container as my own user, I use this::

  $ docker run --rm -it user/pyjnius -U rbrewer -u 1000 -G rbrewer -g 1000 javac -version

To give the java compiler access to files in my current directory, add the docker ``-v``
flag to map the current directory to the container's working directory (``/data``)::

  $ docker run --rm -it -v $PWD:/data user/pyjnius -U rbrewer -u 1000 -G rbrewer -g 1000 javac -version

It's handy to wrap that all up in a script, which I've done with the ``go`` script.
Just modify it to use your user and group, and you can easily use your appliance to run
java or pyjnius and access your local files::

  $ ./go javac -version

To run a pyjnius script inside the appliance, simply do this::

  $ ./go python testpy.py

