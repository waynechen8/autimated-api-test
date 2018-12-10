#Delete
/home/jmeter/apache-jmeter-4.0/bin/jmeter -n -t /home/jmeter/NCHC_Swagger/WL-A01/OOO/jmx/WL-A01_OOO_Delete.jmx

python3 /home/jmeter/NCHC_Swagger/WL-A01/OOO/jmetertodb.py -xmlfile /home/jmeter/NCHC_Swagger/WL-A01/OOO/log/Delete_Result.xml

