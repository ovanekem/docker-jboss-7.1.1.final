# docker-jboss-7.1.1.final
Docker image that builds a JBOSS AS 7.1.1.final server along with JDK 1.7.0_79.

Note: because of the licence restrictions of the Oracle JDK, I cannot push a pre-built image on the Docker hub. You have to build the image yourself and download (and accept) yourself the Terms & Conditions of the Oracle JDK.

First you need to download the Oracle JDK 1.7.0_79 rpm package.

Because you must accept the Terms and Conditions of Oracle prior to installing the Oracle JDK, I have not bundled this into this project. You have to download it separately (and accept yourself the Terms and Conditions). In order to download the rpm, you can go to: http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.rpm and download the jdk-7u79-linux-x64.rpm package into the same directory as the Dockerfile.

In order to build this image just run the following command (it is assumed that Docker is installed properly either natively or with Boot2Docker and started):

    docker build -t ovanekem/docker-jboss-7.1.1.final .
  
Building the project will take some time as it downloads the JBOSS AS package from JBOSS Downloads page.

You can then either run this image or extend it.

In order to run it, run the following Docker command:

    docker run -it -p 8080:8080 -p 9990:9990 ovanekem/docker-jboss-7.1.1.final
  
You can now access (replace <ip_of_docker> with either localhost or the ip of Boot2Docker) http://<ip_of_docker>:8080.
You can log into the administration console of JBOSS using admin as login and welcome1 as password.

In order to extend this image, you can simply write your own Dockerfile that extends this image:

    FROM ovanekem/docker-jboss-7.1.1.final:latest

And customize your image with your project's specifics, for example copy a local standalone.xml to the container,...

