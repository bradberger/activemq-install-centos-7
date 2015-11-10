Initial SSL setup steps are based on the 
[ActiveMQ docs](http://activemq.apache.org/how-do-i-use-ssl.html).

## Set up the Key stores/trust stores

First, create the broker key. It's stored in the keystore with the default password of `password`.
Enter the keystore password, followed by the appropriate values for the broker,
including a new password for the broker if you want to change it.

This method removes the default keystore and replaces it with a new one.

1. Using keytool, create a certificate for the broker:
```bash
cd /opt/activemq/conf
mv broker.ks broker.backup.ks
keytool -genkey -alias broker -keyalg RSA -keystore broker.ks
```

2. Export the broker's certificate so it can be shared with clients:
```bash
keytool -export -alias broker -keystore broker.ks -file broker.cert
```

3. Create a certificate/keystore for the client:
```bash
keytool -genkey -alias client -keyalg RSA -keystore client.ks
```

4. Create a truststore for the client, and import the broker's certificate. This establishes that the client "trusts" the broker:
```
keytool -import -alias broker -keystore client.ts -file broker.cert
```

### Add the passwords

Now to make sure ActiveMQ uses these files and new passwords at startup, add this line to 
the `/etv/profile.d/activemq.sh` file, replacing `=password` with the password you just created:

```bash
export ACTIVEMQ_SSL_OPTS = -Djavax.net.ssl.keyStore=/opt/activemq/conf/broker.ks -Djavax.net.ssl.keyStorePassword=password
```

