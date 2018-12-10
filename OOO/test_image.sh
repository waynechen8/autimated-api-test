cp /home/jmeter/NCHC_Swagger/WL-A01/OOO/config/id_copy.csv /home/jmeter/NCHC_Swagger/WL-A01/OOO/config/id.csv

#Delete exist result
rm -f /home/jmeter/NCHC_Swagger/WL-A01/OOO/log/*

#Create_snapshotimage
/home/jmeter/apache-jmeter-4.0/bin/jmeter -n -t /home/jmeter/NCHC_Swagger/WL-A01/OOO/jmx/WL-A01_OOO_Create_snapshotimage.jmx

python3 /home/jmeter/NCHC_Swagger/WL-A01/OOO/jmetertodb.py -xmlfile /home/jmeter/NCHC_Swagger/WL-A01/OOO/log/Create_Result_Image.xml


#Create
/home/jmeter/apache-jmeter-4.0/bin/jmeter -n -t /home/jmeter/NCHC_Swagger/WL-A01/OOO/jmx/WL-A01_OOO_Create.jmx

python3 /home/jmeter/NCHC_Swagger/WL-A01/OOO/jmetertodb.py -xmlfile /home/jmeter/NCHC_Swagger/WL-A01/OOO/log/Create_Result.xml


#Run(JMX)
/home/jmeter/apache-jmeter-4.0/bin/jmeter -n -t /home/jmeter/NCHC_Swagger/WL-A01/OOO/jmx/WL-A01_OOO_Run.jmx

sleep 3m

python3 /home/jmeter/NCHC_Swagger/WL-A01/OOO/jmetertodb.py -xmlfile /home/jmeter/NCHC_Swagger/WL-A01/OOO/log/Run_Result.xml

