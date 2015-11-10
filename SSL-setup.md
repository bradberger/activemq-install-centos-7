Initial SSL setup steps are based on the 
[ActiveMQ docs](http://activemq.apache.org/how-do-i-use-ssl.html).

First, create the broker key. It's stored in the keystore with the default password of `password`.
Enter the keystore password, followed by the appropriate values for the broker,
including a new password for the broker if you want to change it.

This method removes the default keystore and replaces it with a new one.

```bash
cd /opt/activemq/conf
mv broker.ks
keytool -genkey -alias broker -keyalg RSA -keystore broker.ks
```
