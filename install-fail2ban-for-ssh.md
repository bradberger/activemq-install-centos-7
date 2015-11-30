
```bash
## Install fail2ban
yum install -y epel-release
yum install -u fail2ban

# Copy configuration
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
```

Open the configuration file at `/etc/fail2ban/jail.local` and look for the
section that starts with `[sshd]`. Make sure that this line is added or uncommented:

```
[sshd]
enabled = true
```

Then, make sure the daemon is set up to start on system startup,
and start it up now:

```bash
systemctl enable fail2ban
systemctl start fail2ban
```

You can check that fail2ban is setting iptables rules with the following
command. It should show an entry that inclues the SSH port:

```bash
iptables -L
```
