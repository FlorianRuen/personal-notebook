
## Turn on / off wi-fi depending on ethernet status for Ubuntu

Because it's not useful to connect both Wi-Fi and ethernet at the same time, this small script will disconnect / connect Wi-Fi depending on ethernet status

### 1. Create a bash script

```bash
sudo nano /etc/NetworkManager/dispatcher.d/70-wifi-wired-exclusive.sh
```

Put the following content to the new created script

```bash
#!/bin/bash
export LC_ALL=C

enable_disable_wifi ()
{
    result=$(nmcli dev | grep "ethernet" | grep -w "connected")
    if [ -n "$result" ]; then
        nmcli radio wifi off
    else
        nmcli radio wifi on
    fi
}

if [ "$2" = "up" ]; then
    enable_disable_wifi
fi

if [ "$2" = "down" ]; then
    enable_disable_wifi
fi
```

### 2. Give the permissions and restart the Network manager

```bash
sudo chown root:root /etc/NetworkManager/dispatcher.d/70-wifi-wired-exclusive.sh
sudo chmod 744 /etc/NetworkManager/dispatcher.d/70-wifi-wired-exclusive.sh
```

And finally, restart the NetworkManager to run the script. After you can try to connect / disconnect your ethernet cable to show the magic!

```bash
sudo systemctl restart NetworkManager
```
