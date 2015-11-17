## Overview

Steps 1 and 2 are in the `install-activemq.sh` file. Just run that if you're not interested 
in the process. You'll also need to copy the files in the repository to the server, as well.

1. Install Java
2. Download and install ActiveMQ

## Install Java

### OpenJDK

ActiveMQ requires Java, so the first step is to install Java. The OpenJDK should work
fine, and it simplifies installation:

```bash
yum install java-1.7.0-openjdk
```

You can verify it installed correctly with:

```bash
java -version
```

### Oracle JDK

Alternatively, you can install the Oracle JDK. Pick the appropriate RPM file from
the [Java download page](http://www.oracle.com/technetwork/java/javase/downloads/jre8-downloads-2133155.html).
At time of writing, the latest version was `http://download.oracle.com/otn-pub/java/jdk/8u66-b17/jre-8u66-linux-x64.rpm`. To download and install
it, run the following command, replacing the RPM file name with the latest version:

```bash
cd ~
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie"  "http://download.oracle.com/otn-pub/java/jdk/8u66-b17/jre-8u66-linux-x64.rpm"
sudo yum localinstall jre-8u66-linux-x64.rpm
```

Verify it's install with:

```bash
java -version
```

If you've installed a different version of Java previously, and want to update the 
default version, use the command:

```bash
sudo alternatives --config java
```

## Install ActiveMQ

Download the latest version of ActiveMQ from the Apache website. You'll want to check the archive
integrity after downloading, which can be done with the `md5sum` command. It should match whatever
is listed on the Apache website for the particular version in question. Then unzip the archive and 
move it into the `/opt` directory.


```bash
wget http://www.us.apache.org/dist/activemq/5.12.1/apache-activemq-5.12.1-bin.tar.gz
md5sum apache-activemq*.tar.gz
tar -zxvf apache-activemq*.tar.gz
mv apache-activemq-5.12.1 /opt
ln -s /opt/apache-activemq-5.12.1 /opt/activemq
```

Next, create a system user for ActiveMQ, and set that user as owner of the ActiveMQ directory.

```bash
adduser --system activemq
chown -R activemq: /opt/activemq
```

To make things a bit simpler, add `JAVA_HOME` and the ActiveMQ `bin` directory to
the bash path. To do that, just create a file `/etc/profile.d/activemq.sh` with 
the following contents:

```bash
export JAVA_HOME=/usr/lib/jvm/jre
export PATH=$PATH:/opt/activemq/bin
```

The make sure the script is executable by running:

```bash
chmod +x /etc/profile.d/activemq.sh
```

Now create the init script to control starting/stopping the ActiveMQ as a daemon.
The file name is [/etc/init.d/activemq](etc/init.d/activemq)

After that's all done, you'll (probably) want to set up ActiveMQ to start 
after reboots, so to do that, it's as simple as:

```bash
sudo chkconfig --add activemq
sudo chkconfig activemq on
```

The configuration files are now in `/opt/activemq/conf`.
