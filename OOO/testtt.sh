#Install Nginx

testlist="1 2"
for test in $testlist
do
IP="$(sed -n "$test"p /home/jmeter/NCHC_Swagger/WL-A01/OOO/IP)"
ssh -o "StrictHostKeyChecking no" -i /home/jmeter/NCHC_Swagger/WL-A01/OOO/st-test.pem ubuntu@$IP << EOF
  sudo apt-get update
  sudo apt-get -y install nginx

  exit
EOF
done
