ssh -o "StrictHostKeyChecking no" -i /home/jmeter/NCHC_Swagger/WL-A01/OOO/keypair/"$1".pem ubuntu@"$2" << EOF
  sudo apt-get update
  sudo apt-get -y install nginx
  exit
EOF
