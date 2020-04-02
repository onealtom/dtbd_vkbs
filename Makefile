all: markprint osc_30m72 gen_swu

osc_30m72: markprint osc_30m72_bd gen_swu
osc_122m88: markprint osc_122m88_bd gen_swu

markprint:
	./version.sh

zqv3:
	cpp -Iinclude -E -P -x assembler-with-cpp zynq-zqv3-adrv9375.dts > zynq-zqv3-adrv9375.tmp.dts
	./dtc -I dts -O dtb -o devicetree.dtb zynq-zqv3-adrv9375.tmp.dts

clean:clean_swu
	rm -rf *.dtb
	rm -rf dt_ver.dtsi
	rm -rf *.tmp.dts

install:
	cp ./devicetree.dtb $(DTB_DEST)


gen_swu:
	tar -czf ./swu/dtb.tar.gz devicetree.dtb
	cd swu && ./generate_swu.sh

clean_swu:
	rm -rf swu/*.swu
	rm -rf swu/*.tar.gz



osc_30m72_bd:
	cpp -DOSC_30M72 -Iinclude -E -P -xassembler-with-cpp zynq-zqv3-adrv9375.dts > zynq-zqv3-adrv9375.tmp.dts
	./dtc -I dts -O dtb -o devicetree.dtb zynq-zqv3-adrv9375.tmp.dts

osc_122m88_bd:
	cpp -DOSC_122M88 -Iinclude -E -P -xassembler-with-cpp zynq-zqv3-adrv9375.dts > zynq-zqv3-adrv9375.tmp.dts
	./dtc -I dts -O dtb -o devicetree.dtb zynq-zqv3-adrv9375.tmp.dts