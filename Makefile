all: markprint zqv3 gen_swu

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
