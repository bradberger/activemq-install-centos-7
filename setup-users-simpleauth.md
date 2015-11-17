To set up users, change permissions, edit passwords, etc., using the
Simple Authentication Plugin, edit the main configuration file in
[/opt/activemq/conf/activemq.xml](opt/activemq/conf/activemq.xml).

In this file, you can create users and set passwords, as well as
grant users access to queues/topics. Look for the `<simpleAuthenticationPlugin>`
section. It will look something like this:

```xml
<simpleAuthenticationPlugin>
                <users>
                    <authenticationUser username="admin" password="password" groups="users,admins,producers,consumers" />
                    <authenticationUser username="producer" password="password" groups="users,producers,consumers" />
                    <authenticationUser username="consumer" password="password" groups="users,consumers" />
                    <authenticationUser username="guest" password="guest" groups="guests" />
                </users>
            </simpleAuthenticationPlugin>
            <authorizationPlugin>
                <map>
                    <authorizationMap>
                        <authorizationEntries>
                            <authorizationEntry queue=">" read="admins,producers,consumers" write="admins,producers" admin="admins" />
                            <authorizationEntry topic=">" read="admins,producers,consumers" write="admins,producers" admin="admins" />
                            <authorizationEntry topic="ActiveMQ.Advisory.>" read="all" write="all" admin="all"/>
                        </authorizationEntries>
                        <tempDestinationAuthorizationEntry>
                            <tempDestinationAuthorizationEntry read="admins,producers,consumers" write="admins,producers" admin="admins"/>
                        </tempDestinationAuthorizationEntry>
                    </authorizationMap>
                </map>
            </authorizationPlugin>
```
