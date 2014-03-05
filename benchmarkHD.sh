#!/bin/bash

testfile=$(hexdump -n 16 -v -e '/1 "%02X"' /dev/urandom)

if [ -z "$testfile" ]; then
    echo "Zufalls-Dateiname konnte nicht erstellt werden!"
    exit 1;
fi

echo ""
echo "Write a 2GB file"
time dd if=/dev/zero of=$testfile bs=1024 count=2000000 conv=fdatasync 2>&1 | tail -n1

echo ""
echo "Read a 2GB file"
time dd if=$testfile of=/dev/null conv=fdatasync 2>&1 | tail -n1

echo ""
echo "Copy 2GB file"
time cp $testfile ${testfile}1

rm ${testfile}1

echo ""
echo "Create and delete 5000 x 10KB files"
time $(for i in $(seq 1 5000); do dd if=/dev/zero of=$testfile bs=1024 count=10 2>/dev/null; rm $testfile; done)
