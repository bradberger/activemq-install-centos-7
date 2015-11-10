Setting up MQTT is quite easy, just edit the `/opt/activemq/conf/activemq.xml` file and make sure 
it has MQTT as a transport connector for the broker. Notice in the example below SSL is enabled. If
it wasn't, you'd set the `transportConnector` `uri` attribute without the `+ssl` part. If you're not 
verifying clients (and it doesn't by default) then remove the `trustStore=` attributes.

```xml
<broker>
        <transportConnectors>
            <transportConnector name="mqtt" uri="mqtt+ssl://0.0.0.0:1883?maximumConnections=1000&amp;wireFormat.maxFrameSize=104857600"/>
        </transportConnectors>

       	<sslContext>
            <sslContext keyStore="file:${activemq.conf}/broker.ks"
                        keyStorePassword="password" 
                        trustStore="file:${activemq.conf}/broker.ts"
                        trustStorePassword="password"
            />
        </sslContext>


</broker>
```
