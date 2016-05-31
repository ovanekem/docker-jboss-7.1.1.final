# This is the Dockerfile for JBOSS AS 7.1.1.Final
# 
# IMPORTANT
# ---------
# The resulting image of this Dockerfile DOES NOT contain a JBOSS Domain.
# You will need to create a domain on a new inherited image.
#
# REQUIRED FILES TO BUILD THIS IMAGE
# ----------------------------------
# (1) jdk-7u79-linux-x64.rpm.bin
#     Download from http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.rpm

FROM jboss/base:latest
MAINTAINER Olivier Vanekem <olivier.vanekem@gmail.com>

# Define JBOSS admin user and password
ENV ADMIN_USER admin
ENV ADMIN_PASSWORD welcome1

# User root user to install software
USER root

# Install necessary packages
RUN yum -y install wget
RUN yum clean all

COPY jdk-7u79-linux-x64.rpm /opt/
RUN rpm -i /opt/jdk-7u79-linux-x64.rpm && rm /opt/jdk-7u79-linux-x64.rpm

# Switch back to jboss user
USER jboss

# Set the JAVA_HOME variable to make it clear where Java is located
ENV JAVA_HOME /usr/java/jdk1.7.0_79

# Add the jboss as distribution
RUN cd $HOME \
    && wget -O jboss-as-7.1.1.Final.zip http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.zip \
    && unzip jboss-as-7.1.1.Final.zip \
    && rm jboss-as-7.1.1.Final.zip 

# Add admin user
RUN /opt/jboss/jboss-as-7.1.1.Final/bin/add-user.sh --silent=true $ADMIN_USER $ADMIN_PASSWORD

# Expose ports   
EXPOSE 8080
EXPOSE 9990

CMD ["/opt/jboss/jboss-as-7.1.1.Final/bin/standalone.sh", "-b=0.0.0.0", "-bmanagement=0.0.0.0"]
