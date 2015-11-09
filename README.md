## Overview

Steps 1 and 2 are in the `install-activemq.sh` file. Just run that if you're not interested 
in the process. You'll also need to copy the files in the repository to the server, as well.

1. Install Java
2. Download and install ActiveMQ

## Install Java

ActiveMQ requires Java, so the first step is to install Java. The OpenJDK should work
fine, and it simplifies installation:

```bash
yum install java-1.7.0-openjdk
```

You can verify it installed correctly with:

```bash
java -version
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
The file name is `/etc/init.d/activemq`

```bash
#!/bin/bash
#
# activemq	 Starts ActiveMQ.
#
# chkconfig: 345 88 12
# description: ActiveMQ is a JMS Messaging Queue Server.
### BEGIN INIT INFO
# Provides: $activemq
### END INIT INFO

# Source function library.
. /etc/init.d/functions

RETVAL=0

umask 077

start() {
       echo -n $"Starting ActiveMQ: "
       daemon /opt/activemq/bin/activemq start
       echo
       return $RETVAL
}
stop() {
       echo -n $"Shutting down ActiveMQ: "
       daemon su -c /opt/activemq/bin/activemq stop
       echo
       return $RETVAL
}
restart() {
       stop
       start
}
case "$1" in
start)
       start
       ;;
stop)
       stop
       ;;
status)
       /opt/activemq/bin/activemq status
       ;;
restart|reload)
       restart
       ;;
*)
       echo $"Usage: $0 {start|stop|restart}"
       exit 1
esac

exit $?
```

After that's all done, you'll (probably) want to set up ActiveMQ to start 
after reboots, so to do that, it's as simple as:

```bash
sudo chkconfig --add activemq
sudo chkconfig activemq on
```
