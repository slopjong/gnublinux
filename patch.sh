#!/bin/bash

patches=( '001-mmc-card-detect' '002-gpiolib 003-usb-panic' 'adc-registers' '006_lpc313x_ADC_PWM' )
patch_path="gnublin/lpc3131/kernel/2.6.33"

# change to the linux source directory
cd linux*
git checkout 093e9d2f7f730dee86d6734f7a66fc573bcd7027

# patch the source
for patch in ${patches[@]}
do
  patch -p1 < "../${patch_path}/${patch}.patch"
done

cp "../${patch_path}/config-adcpwm" .config 