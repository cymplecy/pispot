#!/bin/bash
# RPi SSID Scanner
# from code by Lasse Christiansen http://lcdev.dk
 
createAdHocNetwork(){
    echo "Code for activiating hotpspot network"
    echo "Hotspot network will have been created once code sorted"
}
 
echo "================================="
echo "RPi Network Conf Bootstrapper 0.1sw1"
echo "================================="
echo "Scanning for known WiFi networks"
ssids=( 'CYCY' 'ClassPi' )
connected=false
for ssid in "${ssids[@]}"
do
    if iwlist wlan0 scan | grep $ssid > /dev/null
    then
        echo "First WiFi in range has SSID:" $ssid
        #echo "Starting supplicant for WPA/WPA2"
        #wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf > /dev/null 2>&1
        echo "Checking if getting valid IP from DHCP"
        if dhclient -1 wlan0
        then
            echo "Connected to WiFi"
            connected=true
            break
        else
            echo "DHCP server did not respond with an IP lease (DHCPOFFER)"
            wpa_cli terminate
            break
        fi
    else
        echo "Not in range, WiFi with SSID:" $ssid
    fi
done
 
if ! $connected; then
    createAdHocNetwork
fi
 
exit 0