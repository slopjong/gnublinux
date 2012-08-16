export ARCH=arm 

# Depending on what cross-compiler toolchain you use
# you have to uncomment the one you use whil commenting
# out the other
export CROSS_COMPILE=arm-none-linux-gnueabi-
#export CROSS_COMPILE=arm-linux-gnueabi-

cd linux*
make menuconfig
