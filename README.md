# nvidiadriversonunraidinstaller
A script for installing / instructions for installing nvidia drivers / CUDA drivers on Unraid.

## Step 1:

Run part1.sh, this will sort out the new kernel to start being made:

## Step 2:

Now we need to add the nvidia drivers and modules to the kernel.

Download and install drivers from nvidia:

https://developer.nvidia.com/compute/cuda/10.0/Prod/local_installers/cuda_10.0.130_410.48_linux

Note if you are doing GPU passthrough you need to use the same files for host and docker.

```
CUDA_RUN="https://developer.nvidia.com/compute/cuda/10.0/Prod/local_installers/cuda_10.0.130_410.48_linux"
cd /opt && \
  wget $CUDA_RUN && \
  chmod +x cuda_10.0.130_410.48_linux && \
  mkdir nvidia_installers && \
  ./cuda_10.0.130_410.48_linux -extract=`pwd`/nvidia_installers && \
  cd nvidia_installers && \
  ./NVIDIA-Linux-x86_64-410.48.run -s -N --no-kernel-module

cd /opt/nvidia_installers && ls -alh && \
  ./cuda-linux.10.0.130-24817639.run -noprompt

# Ensure the CUDA libs and binaries are in the correct environment variables
LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-10.0/lib64
PATH=$PATH:/usr/local/cuda-10.0/bin
```


## Step 3:

Run part2.sh, this will sort out packaging the modules and kernel as Unraid expects it.

## Step 4

Now manually replace bzfirmware bzimage bzmodules bzroot bzroot-gui with their new generated replacements from the following folder:  ./unraidversionnumber/stock/ into /boot/

## Step 5
Reboot and re-run Step 2 to re-install the drivers (Unraid purges the filesystem on reboot afterall.)

Further documentation can be found here: https://stackoverflow.com/questions/25185405/using-gpu-from-a-docker-container

Many thanks to [@CHBMB](https://github.com/CHBMB/) as I've edited from his script.

Please note I have not automated many steps and you need to re-install the drivers in step 2 everytime you reboot.
(Someone make a plugin to do it? Or write a script to be cron'd)
