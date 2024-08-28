# NEP-Replace
This Project is aimed at providing a Full Nepviewer App Replacement

## Requirements
-Pi Zero W2 / Some other device with a network card capable of creating an accesspoint  
-SD Card

## Installation for Pi Zero W2 (with Raspbian 32bit Desktp)
<pre>
  git clone https://github.com/Terraminator/NEP-Replace.git
  cd NEP-Replace
  sed 's/NETWORK_NAME="CHANGEME"/NETWORK_NAME="YOUR_NETWORK_NAME"' -i ap_setup.sh
  sed 's/NETWORK_PASS="CHANGEME"/NETWORK_PASS="YOUR_NETWORK_PASS"' -i ap_setup.sh
  chmod +x setup.sh
  ./setup.sh
</pre>

## Usage
After the installation your pi will open an accesspoint YOUR_NETWORK_NAME with the password YOUR_NETWORK_PASS.  
You will then have to setup your inverter to enter this Network by following the instructions for your inverter.  
The inverter will no longer communicate with the Nepviewer cloud, but with your pi.  
To get the Power and Energy Diagrams you have to join the network YOUR_NETWORK_NAME and open the page:   
"http://solar.info" / (http://192.168.12.1 if you are not using the dns server of the pi)
