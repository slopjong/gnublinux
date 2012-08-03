#!/bin/bash

# change to the linux source directory
cd linux*

## This patch script uses a modified version of the 0006_lpc313x_ADC_PWM patch because
## the one provided in the gnublin git repository lets the compilation fail.
## If you want to use the original patch file, uncomment the next line and comment out 
## the two lines after.
#patches=( '001-mmc-card-detect' '002-gpiolib 003-usb-panic' 'adc-registers' '0006_lpc313x_ADC_PWM' )
patch -p1 < ../0006_lpc313x_ADC_PWM_2.patch
patches=( '001-mmc-card-detect' '002-gpiolib 003-usb-panic' 'adc-registers' )

patch_path="gnublin/lpc3131/kernel/2.6.33"

git checkout 093e9d2f7f730dee86d6734f7a66fc573bcd7027

# patch the source
for patch in ${patches[@]}
do
  patch -p1 < "../${patch_path}/${patch}.patch"
done

cp "../${patch_path}/config-adcpwm" .config 
