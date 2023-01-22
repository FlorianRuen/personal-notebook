## How to install Nvidia GPU Drivers to use with tensorflow inside docker

In this tutorial, we need to install Tensorflow 1.15.5 (latest version supported by our project for now) using GPU Drivers (Nvidia)
The concerned OS is Ubuntu 22.04

### 1. Install GPU Drivers and CUDA 10.2

We are looking to install GPU Drivers **470.141.03** (*latest version that work with CUDA 10.2*)
First, you can download the driver (.run file) directly from the official Nvidia website: [here is the direct link to the driver](https://www.nvidia.com/content/DriverDownload-March2009/confirmation.php?url=/XFree86/Linux-x86_64/470.141.03/NVIDIA-Linux-x86_64-470.141.03.run&lang=us&type=TITAN) (if not working due to confirmation page, go [from this page](https://www.nvidia.com/en-us/drivers/unix/) and search for the driver version)

When download is finished, you can run the script

```bash
sudo sh NVIDIA-Linux-x86_64-470.141.03.run
```

**Be careful : not other driver have to be installed before or the setup will failed with error message**
If other packages has been installed, you can remove all of them with

```bash
sudo apt remove "*nvidia*"
```

The first screen will ask you to accept the EULA terms and conditions, accept them.
Ad the next one, will ask you which components you want to install. You can select all of them (if no drivers previously installed)

**Note : you can also install the driver first by using the commands bellow and after install cuda just by unselecting driver in previus setup**

```bash
sudo apt install nvidia-driver-470"
sudo sh NVIDIA-Linux-x86_64-470.141.03.run # unselect the NVIDIA drivers on the second step here 
```

### 2. Install cudnn 7 that matched CUDA 10.2

You can download the cudnn 7 archive (for CUDA 10.2, be careful), directly from the NVIDIA website [using this direct link](https://developer.nvidia.com/compute/machine-learning/cudnn/secure/7.6.5.32/Production/10.2_20191118/cudnn-10.2-linux-x64-v7.6.5.32.tgz)

When download is finished, extract them and copy all the files to the CUDA directory using

```bash
tar -xzvf cudnn-10.2-linux-x64-v7.6.5.32.tgz
sudo cp cuda/include/cudnn*.h /usr/local/cuda/include
sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*
```

At this time, the command 

```bash
nvidia-smi 
```

should display something like the following message. If it's not the case, try to reboot your computer for all the changes to take effect

```bash
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 470.141.03   Driver Version: 470.141.03   CUDA Version: 11.4     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  NVIDIA GeForce ...  Off  | 00000000:03:00.0 Off |                  N/A |
| N/A   47C    P0    10W /  N/A |      4MiB /  3914MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
+-----------------------------------------------------------------------------+
```

### 3. Install nvidia docker runtime

```bash
sudo apt-get install -y nvidia-docker2
```

### 4. Create auto-rebuild script when kernel upgrade (optional)

The problem is, when Ubuntu will upgrade your kernel, all the nvidia drivers must be rebuild to works as expected
In order to auto-rebuild, my solution is to execute a script at startup

If plugins are not working (using result of nvidia-smi command), it will automatically run all the commands above

```bash
#! /bin/bash

if [ $(exec nvidia-smi | grep failed | wc -l) -eq "0" ];
then
        notify-send "NVIDIA drivers not working, installation will begin"
        sudo -A apt remove "*nvidia*" -y
        sudo -A apt install nvidia-driver-470 -y
        notify-send "NVIDIA drivers rebuilt!"
fi
```

This password will require a password, so it's easier to launch it manually, but if you want to setup as startup script you can follow these steps

Create a system.d file in `/etc/systemd/system` and put the following content inside

```bash
[Unit]
After=network.target

[Service]
ExecStart=/usr/local/bin/auto-upgrade-nvidia-drivers.sh

[Install]
WantedBy=default.target
```

Where auto-upgrade-nvidia-drivers.sh is the file that contain the previous code
Finally, set the permissions and run the service when your computer starts

```bash
sudo chmod 744 /usr/local/bin/auto-upgrade-nvidia-drivers.sh
sudo chmod 664 /etc/systemd/system/auto-upgrade-nvidia-drivers.service

sudo systemctl daemon-reload
sudo systemctl enable auto-upgrade-nvidia-drivers.service
```
