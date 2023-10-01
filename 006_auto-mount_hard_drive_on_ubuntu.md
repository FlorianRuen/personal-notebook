
## How to automatically mount second hard drive on Ubuntu

### 1. Edit fstab

```bash
sudo nano /etc/fstab
```

Add a line to describe your drive

```bash
UUID=17c16659-0f69-4fb7-9d2c-05c6853e8241 /media/florian/hdd2 ext4 defaults
```

To find the UUID of the hard drive, you can use the command

```bash
sudo blkid
```

### 2. Apply changes

To apply changes, you can use the command

```bash
sudo mount -a
```
