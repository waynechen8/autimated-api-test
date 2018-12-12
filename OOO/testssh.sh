input="./config/id1.csv"
sed 1d $input | while IFS="," read -r f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12 f13 f14 f15
do
  chmod 400 /home/jmeter/NCHC_Swagger/WL-A01/OOO/keypair/"$f4".pem
  sh installNginx.sh $f4 $f10 &
done
wait
echo "SSH Step Finished"
