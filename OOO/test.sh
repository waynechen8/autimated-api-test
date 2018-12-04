#!/bin/bash
#Run(Mount Volume, Stress)

date="$(date +"%m%d%H%M")"
S="$date"_"$1"

#Delete exist result
rm -f /home/jmeter/NCHC_Swagger/WL-A01/OOO/Create_Result_Image.xml
rm -f /home/jmeter/NCHC_Swagger/WL-A01/OOO/Create_Result.xml
rm -f /home/jmeter/NCHC_Swagger/WL-A01/OOO/Run_Result.xml
rm -f /home/jmeter/NCHC_Swagger/WL-A01/OOO/Stop_Result.xml
rm -f /home/jmeter/NCHC_Swagger/WL-A01/OOO/Resume_Result.xml
rm -f /home/jmeter/NCHC_Swagger/WL-A01/OOO/Delete_Result.xml

#Create_snapshotimage
/home/jmeter/apache-jmeter-4.0/bin/jmeter -Jserial_number=$S -n -t /home/jmeter/NCHC_Swagger/WL-A01/OOO/WL-A01_OOO_Create_snapshotimage.jmx

python3 /home/jmeter/NCHC_Swagger/WL-A01/OOO/jmetertodb.py -xmlfile /home/jmeter/NCHC_Swagger/WL-A01/OOO/Create_Result_Image.xml

chmod 400 /home/jmeter/NCHC_Swagger/WL-A01/OOO/keypairs_$S.pem
remoteVmIp="$(cat /home/jmeter/NCHC_Swagger/WL-A01/OOO/vm01-ip_$S.properties | sed -n '3p' | cut -d "=" -f2)"

#Install Nginx
ssh -o "StrictHostKeyChecking no" -i /home/jmeter/NCHC_Swagger/WL-A01/OOO/keypairs_$S.pem ubuntu@$remoteVmIp << EOF
  sudo apt-get update
  sudo apt-get -y install nginx

  exit
EOF

#Create
/home/jmeter/apache-jmeter-4.0/bin/jmeter -Jserial_number=$S -n -t /home/jmeter/NCHC_Swagger/WL-A01/OOO/WL-A01_OOO_Create.jmx

python3 /home/jmeter/NCHC_Swagger/WL-A01/OOO/jmetertodb.py -xmlfile /home/jmeter/NCHC_Swagger/WL-A01/OOO/Create_Result.xml

#Stress
remoteVmIp="$(cat /home/jmeter/NCHC_Swagger/WL-A01/OOO/vm02-ip_$S.properties | sed -n '3p' | cut -d "=" -f2)"

ssh -o "StrictHostKeyChecking no" -i /home/jmeter/NCHC_Swagger/WL-A01/OOO/keypairs_$S.pem ubuntu@$remoteVmIp << EOF
  sudo apt-get update
  sudo apt-get -y install stress git

  sudo mkfs.ext4 /dev/vdb
  sudo mkdir /home/ubuntu/volume
  sudo mount /dev/vdb  /home/ubuntu/volume

  sudo git clone https://github.com/tensorflow/tensorflow.git /home/ubuntu/volume/tensorflow

  stress -c 16 --timeout 10m --backoff 100000000

  exit
EOF

#Run(JMX)
/home/jmeter/apache-jmeter-4.0/bin/jmeter -Jserial_number=$S -n -t /home/jmeter/NCHC_Swagger/WL-A01/OOO/WL-A01_OOO_Run.jmx 

sleep 3m

python3 /home/jmeter/NCHC_Swagger/WL-A01/OOO/jmetertodb.py -xmlfile /home/jmeter/NCHC_Swagger/WL-A01/OOO/Run_Result.xml

#Stop
/home/jmeter/apache-jmeter-4.0/bin/jmeter -Jserial_number=$S -n -t /home/jmeter/NCHC_Swagger/WL-A01/OOO/WL-A01_OOO_Stop.jmx

sleep 5m

python3 /home/jmeter/NCHC_Swagger/WL-A01/OOO/jmetertodb.py -xmlfile /home/jmeter/NCHC_Swagger/WL-A01/OOO/Stop_Result.xml

#Resume
/home/jmeter/apache-jmeter-4.0/bin/jmeter -Jserial_number=$S -n -t /home/jmeter/NCHC_Swagger/WL-A01/OOO/WL-A01_OOO_Resume.jmx 

sleep 5m

python3 /home/jmeter/NCHC_Swagger/WL-A01/OOO/jmetertodb.py -xmlfile /home/jmeter/NCHC_Swagger/WL-A01/OOO/Resume_Result.xml

#Delete
/home/jmeter/apache-jmeter-4.0/bin/jmeter -Jserial_number=$S -n -t /home/jmeter/NCHC_Swagger/WL-A01/OOO/WL-A01_OOO_Delete.jmx 

python3 /home/jmeter/NCHC_Swagger/WL-A01/OOO/jmetertodb.py -xmlfile /home/jmeter/NCHC_Swagger/WL-A01/OOO/Delete_Result.xml

