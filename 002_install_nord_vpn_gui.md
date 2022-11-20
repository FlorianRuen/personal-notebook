
## How to install an unofficial GUI client to use Nord VPN

It's possible to use NordVPN using a CLI, but not very easy to change server location, auto-connect and change other settings
So an unofficial GUI exists (in Python), but some requirements needs to be done before installation

**Be careful : this was tested with Python3.10, it seems not working correctly with Python3.6 or Python3.8**

### 1. Clone the repository

We will use the program located in https://github.com/GoBig87/NordVpnLinuxGUI

```bash
git clone https://github.com/GoBig87/NordVpnLinuxGUI
```

### 2. Install all required libraries

Here is the list of required packages : 

- Nord VPN CLI
- Python3 Pygame
- Few libraries for Pillow and dev libraries
- Library to manage JPEG (Pillow)

To install all of them, you can run the following commands

```bash
sudo apt-get install nordvpn
sudo apt-get install python3-pygame

sudo apt-get install libsdl-image1.2-dev libsdl-mixer1.2-dev libsdl-ttf2.0-dev libsdl1.2-dev libsmpeg-dev libportmidi-dev ffmpeg libswscale-dev libavformat-dev libavcodec-dev libfreetype6-dev

sudo apt install libjpeg-dev zlib1g-dev
```

### 3. Install the NordVpnLinuxGUI

Now, all required libraries are installed, you can go into the cloned folder and run

```bash
./installer.sh
```

**Depending on your python3 version, you can update the code to change from python3 to python3.10 in installer.sh line 45 + NordVPNLinuxGUI.sh line 4 **

Everything fine, you can go in your app launch to launch Nord VPN (be careful to run this app, and not the Nord VPN CLI, that create also a Desktop Icon)

### 4. Monitor the VPN Status

For this, no existing library works very well, so I'm using the ConkyRC
You can find all configuration here : [WORK IN PROGRESS]
