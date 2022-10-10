#!/bin/bash

wget https://raw.githubusercontent.com/emp-toolkit/emp-readme/master/scripts/install.py
python3 install.py --install --tool --ot --sh2pc --ag2pc
cd ~/reDeco/2pc/sh_test
mkdir build && cd build && cmake .. && make
cd ~/reDeco/ && mkdir -p ~/reDeco/zksnark/bin/c++/2pc/
cp ~/reDeco/2pc/sh_test/build/bin/prf ~/reDeco/zksnark/bin/c++/2pc/
cp ~/reDeco/2pc/sh_test/build/bin/prf_client_finished ~/reDeco/zksnark/bin/c++/2pc/
cp ~/reDeco/2pc/sh_test/build/bin/prf_server_finished ~/reDeco/zksnark/bin/c++/2pc/
cp ~/reDeco/2pc/sh_test/build/bin/hmac_setup ~/reDeco/zksnark/bin/c++/2pc/
cp ~/reDeco/2pc/sh_test/build/bin/hmac_outer_hash ~/reDeco/zksnark/bin/c++/2pc/

cd ~/reDeco/jsnark/JsnarkCircuitBuilder && wget https://www.bouncycastle.org/download/bcprov-jdk15on-159.jar
cd ~/reDeco/jsnark/libsnark/ && mkdir build && cd build && cmake .. -DMULTICORE=ON && make
cd ~/reDeco/
cp -r ~/reDeco/jsnark/libsnark/build/libsnark/jsnark_interface ~/reDeco/zksnark/bin/c++
cd ~/reDeco/jsnark/JsnarkCircuitBuilder && mkdir -p bin
javac -d bin -cp /usr/share/java/junit4.jar:bcprov-jdk15on-159.jar  $(find ./src/* | grep ".java$")
cp -r ~/reDeco/jsnark/JsnarkCircuitBuilder/bin ~/reDeco/zksnark/
cp ~/reDeco/jsnark/JsnarkCircuitBuilder/config.properties ~/reDeco/zksnark/

