
all: markprint vkbs_dtc

zc706: markprint zc706_dtc

vkbs: markprint vkbs_dtc

markprint:
	./version.sh

zc706_dtc:
#	cpp -Iinclude -E -P -x assembler-with-cpp ad9523.dtsi > ad9523.tmp.dtsi
	cpp -Iinclude -E -P -x assembler-with-cpp zynq-zc706-adv7511-adrv9009.dts > zynq-zc706-adv7511-adrv9009.tmp.dts
	./dtc -I dts -O dtb -o zynq-zc706-adv7511-adrv9009.dtb zynq-zc706-adv7511-adrv9009.tmp.dts

vkbs_dtc:
	cpp -Iinclude -E -P -x assembler-with-cpp zynq-vkbs-adrv9009.dts > zynq-vkbs-adrv9009.tmp.dts
	./dtc -I dts -O dtb -o devicetree.dtb zynq-vkbs-adrv9009.tmp.dts

clean:
	rm -rf *.dtb
	rm -rf dt_ver.dtsi
	rm -rf *.tmp.dts

install:
	cp ./devicetree.dtb $(DTB_DEST)