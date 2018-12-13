cp /home/jmeter/NCHC_Swagger/WL-A01/SOC/config/id_copy.csv /home/jmeter/NCHC_Swagger/WL-A01/SOC/config/id.csv

#Delete exist result
rm -f /home/jmeter/NCHC_Swagger/WL-A01/SOC/log/*
rm -f /home/jmeter/NCHC_Swagger/WL-A01/SOC/keypair/*

#Create_snapshotimage
/home/jmeter/apache-jmeter-4.0/bin/jmeter -Jthread=2 -n -t /home/jmeter/NCHC_Swagger/WL-A01/SOC/jmx/WL-A01_SOC_Create_snapshotimage.jmx

python3 /home/jmeter/NCHC_Swagger/WL-A01/SOC/jmetertodb.py -xmlfile /home/jmeter/NCHC_Swagger/WL-A01/SOC/log/Create_Result_Image.xml

sleep 1m

input="./config/id1.csv"
sed 1d $input | while IFS="," read -r f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12 f13 f14 f15
do
  chmod 400 /home/jmeter/NCHC_Swagger/WL-A01/SOC/keypair/"$f4".pem
  sh installNginx.sh $f4 $f10 &
done
wait
echo "SSH Step Finished" 

#Create
/home/jmeter/apache-jmeter-4.0/bin/jmeter -Jthread=2 -n -t /home/jmeter/NCHC_Swagger/WL-A01/SOC/jmx/WL-A01_SOC_Create.jmx

python3 /home/jmeter/NCHC_Swagger/WL-A01/SOC/jmetertodb.py -xmlfile /home/jmeter/NCHC_Swagger/WL-A01/SOC/log/Create_Result.xml

input="./config/id1.csv"
sed 1d $input | while IFS="," read -r f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12 f13 f14 f15
do
  sh stressTest.sh $f4 $f6 &
done
wait
echo "SSH Step Finished"

#Run(JMX)
/home/jmeter/apache-jmeter-4.0/bin/jmeter -Jthread=2 -n -t /home/jmeter/NCHC_Swagger/WL-A01/SOC/jmx/WL-A01_SOC_Run.jmx

sleep 3m

python3 /home/jmeter/NCHC_Swagger/WL-A01/SOC/jmetertodb.py -xmlfile /home/jmeter/NCHC_Swagger/WL-A01/SOC/log/Run_Result.xml

#Stop
/home/jmeter/apache-jmeter-4.0/bin/jmeter -Jthread=2 -n -t /home/jmeter/NCHC_Swagger/WL-A01/SOC/jmx/WL-A01_SOC_Stop.jmx

sleep 5m

python3 /home/jmeter/NCHC_Swagger/WL-A01/SOC/jmetertodb.py -xmlfile /home/jmeter/NCHC_Swagger/WL-A01/SOC/log/Stop_Result.xml

#Resume
/home/jmeter/apache-jmeter-4.0/bin/jmeter -Jthread=2 -n -t /home/jmeter/NCHC_Swagger/WL-A01/SOC/jmx/WL-A01_SOC_Resume.jmx

sleep 5m

python3 /home/jmeter/NCHC_Swagger/WL-A01/SOC/jmetertodb.py -xmlfile /home/jmeter/NCHC_Swagger/WL-A01/SOC/log/Resume_Result.xml

#Delete
/home/jmeter/apache-jmeter-4.0/bin/jmeter -n -t /home/jmeter/NCHC_Swagger/WL-A01/SOC/jmx/WL-A01_SOC_Delete.jmx

python3 /home/jmeter/NCHC_Swagger/WL-A01/SOC/jmetertodb.py -xmlfile /home/jmeter/NCHC_Swagger/WL-A01/SOC/log/Delete_Result.xml

