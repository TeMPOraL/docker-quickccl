FROM ubuntu:trusty
MAINTAINER Jacek Złydach <jz@s-arts.pl>

# Based on https://github.com/davazp/docker-sbcl & https://github.com/davazp/docker-quicksbcl

## Set up server
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y make wget bzip2 subversion

## Download & install CCL
ENV HOME /root

WORKDIR /tmp/

RUN svn co http://svn.clozure.com/publicsvn/openmcl/release/1.10/linuxx86/ccl

## Download & install quicklisp

RUN wget http://beta.quicklisp.org/quicklisp.lisp
ADD install.lisp /tmp/install.lisp

RUN /tmp/ccl/lx86cl64 -l /tmp/install.lisp
RUN ln -s /tmp/ccl/lx86cl64 /usr/bin/ccl

WORKDIR /root
