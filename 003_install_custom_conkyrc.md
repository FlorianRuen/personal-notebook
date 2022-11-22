
## How to install custom Conky RC (monitoring tool)

To monitor every metrics about your system, you can Conky which is an higly customizable plugin for Linux
Here is few lines about how to install Conky and how to install a custom template with more informations (VPN, Cryptos ...)

### 1. Install CONKY

Just need to run the following command to install it (type y and enter when prompted)

```bash
sudo apt-get install conky-all
```

### 2. Install custom template

My custom Conky template display standard informations about CPU, CGU, Network, Disk and add few informations related to VPN (work only with NordVPN
at the moment, and it require NordVPN CLI to be installed and logged in)

To proceed, you can change the conky.conf file, and use mine : [you can find my config file here](https://github.com/FlorianRuen/personal-notebook/blob/main/conky/conky.conf)


### 3. Customiza this template

To customiza, just follow the conky documentation to check all available variables
You can also use the exec command to execute shell scripts and display results on your conky desktop widgets

More customization will come in the next few weeks, with for example, the crypto-currency trends !
