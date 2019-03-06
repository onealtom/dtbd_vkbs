all: markprint zc706_ad937x

markprint:
	./version.sh

zc706_ad937x:
	cpp -Iinclude -E -P -x assembler-with-cpp zynq-zc706-adv7511-adrv9375.dts > zynq-zc706-adv7511-adrv9375.tmp.dts
	./dtc -I dts -O dtb -o devicetree.dtb zynq-zc706-adv7511-adrv9375.tmp.dts

clean:
	rm -rf *.dtb
	rm -rf dt_ver.dtsi
	rm -rf *.tmp.dts

install:
	cp ./devicetree.dtb $(DTB_DEST)
