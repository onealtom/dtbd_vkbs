default:
#	./version.sh
#	cpp -Iinclude -E -P -x assembler-with-cpp ad9523.dtsi > ad9523.tmp.dtsi
	cpp -Iinclude -E -P -x assembler-with-cpp zynq-zc706-adv7511-adrv9009.dts > zynq-zc706-adv7511-adrv9009.tmp.dts
	./dtc -I dts -O dtb -o devicetree.dtb zynq-zc706-adv7511-adrv9009.tmp.dts
clean:
	rm -rf *.dtb
#	rm -rf dt_ver.dtsi
	rm -rf zynq-zc706-adv7511-adrv9009.tmp.dts