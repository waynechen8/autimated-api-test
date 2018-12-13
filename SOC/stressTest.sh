ssh -o "StrictHostKeyChecking no" -i /home/jmeter/NCHC_Swagger/WL-A01/OOO/"$1".pem ubuntu@"$2" << EOF
  sudo apt-get update
  sudo apt-get -y install stress git

  sudo mkfs.ext4 /dev/vdb
  sudo mkdir /home/ubuntu/volume
  sudo mount /dev/vdb  /home/ubuntu/volume

  sudo git clone https://github.com/tensorflow/tensorflow.git /home/ubuntu/volume/tensorflow

  stress -c 16 --timeout 10m --backoff 10000000

  exit
EOF
