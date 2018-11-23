#!/bin/bash
#Run(Mount Volume, Stress)

#Delete exist result
rm -f /home/jmeter/NCHC_Swagger/WL-A01/OOO/Create_Result.xml
rm -f /home/jmeter/NCHC_Swagger/WL-A01/OOO/Run_Result.xml
rm -f /home/jmeter/NCHC_Swagger/WL-A01/OOO/Stop_Result.xml
rm -f /home/jmeter/NCHC_Swagger/WL-A01/OOO/Resume_Result.xml
rm -f /home/jmeter/NCHC_Swagger/WL-A01/OOO/Delete_Result.xml

#Create
/home/jmeter/apache-jmeter-4.0/bin/jmeter -n -t /home/jmeter/NCHC_Swagger/WL-A01/OOO/WL-A01_OOO_Create.jmx -l /home/jmeter/NCHC_Swagger/WL-A01/OOO/WL-A01_OOO_Create.jtl

python3 /home/jmeter/NCHC_Swagger/WL-A01/OOO/jmetertodb.py -xmlfile /home/jmeter/NCHC_Swagger/WL-A01/OOO/Create_Result.xml


#chmod 400 /home/jmeter/NCHC_Swagger/WL-A01/OOO/keypairs.pem
#remoteVmIp="$(cat /home/jmeter/NCHC_Swagger/WL-A01/OOO/wla01.properties | sed -n '3p' | cut -d "=" -f2)"
:'
ssh -i /home/jmeter/NCHC_Swagger/WL-A01/OOO/keypairs.pem ubuntu@$remoteVmIp << EOF
  sudo apt-get update
  sudo apt-get -y install stress git

  sudo mkfs.ext4 /dev/vdb
  sudo mkdir /home/ubuntu/volume
  sudo mount /dev/vdb  /home/ubuntu/volume

  sudo git clone https://github.com/tensorflow/tensorflow.git /home/ubuntu/volume/tensorflow

  stress -c 16 --timeout 10m --backoff 100000000

  exit
EOF
'

#Run(JMX)
/home/jmeter/apache-jmeter-4.0/bin/jmeter -n -t /home/jmeter/NCHC_Swagger/WL-A01/OOO/WL-A01_OOO_Run.jmx -l /home/jmeter/NCHC_Swagger/WL-A01/OOO/WL-A01_OOO_Run.jtl

sleep 3m

python3 /home/jmeter/NCHC_Swagger/WL-A01/OOO/jmetertodb.py -xmlfile /home/jmeter/NCHC_Swagger/WL-A01/OOO/Run_Result.xml

#Stop
/home/jmeter/apache-jmeter-4.0/bin/jmeter -n -t /home/jmeter/NCHC_Swagger/WL-A01/OOO/WL-A01_OOO_Stop.jmx -l /home/jmeter/NCHC_Swagger/WL-A01/OOO/WL-A01_OOO_Stop.jtl

sleep 5m

python3 /home/jmeter/NCHC_Swagger/WL-A01/OOO/jmetertodb.py -xmlfile /home/jmeter/NCHC_Swagger/WL-A01/OOO/Stop_Result.xml

#Resume
/home/jmeter/apache-jmeter-4.0/bin/jmeter -n -t /home/jmeter/NCHC_Swagger/WL-A01/OOO/WL-A01_OOO_Resume.jmx -l /home/jmeter/NCHC_Swagger/WL-A01/OOO/WL-A01_OOO_Resume.jtl

sleep 5m

python3 /home/jmeter/NCHC_Swagger/WL-A01/OOO/jmetertodb.py -xmlfile /home/jmeter/NCHC_Swagger/WL-A01/OOO/Resume_Result.xml

#Delete
/home/jmeter/apache-jmeter-4.0/bin/jmeter -n -t /home/jmeter/NCHC_Swagger/WL-A01/OOO/WL-A01_OOO_Delete.jmx -l /home/jmeter/NCHC_Swagger/WL-A01/OOO/WL-A01_OOO_Delete.jtl

python3 /home/jmeter/NCHC_Swagger/WL-A01/OOO/jmetertodb.py -xmlfile /home/jmeter/NCHC_Swagger/WL-A01/OOO/Delete_Result.xml

