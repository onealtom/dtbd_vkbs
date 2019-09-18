#!/bin/sh

if [ $# -lt 1 ]; then
	exit 0;
fi

function get_current_root_device
{
	for i in `cat /proc/cmdline`; do
		if [ ${i:0:5} = "root=" ]; then
			CURR_ROOT="${i:5}"
		fi
	done
	EMMC_DEV=${CURR_ROOT:0:-1}

}

function get_update_part
{
	CURR_ROOT_PART="${CURR_ROOT: -1}"
	if [ $CURR_ROOT_PART = "2" ]; then
		SPAR_ROOT_PART="5";
		CURR_SLOT="A";
		SPAR_SLOT="B";
	else
		SPAR_ROOT_PART="2";
		CURR_SLOT="B";
		SPAR_SLOT="A";
	fi

	#echo "CURR_ROOT_PART="$CURR_ROOT_PART

	CURR_BLR_PART=`expr $CURR_ROOT_PART - 1`
	SPAR_BLR_PART=`expr $SPAR_ROOT_PART - 1`

	CURR_PSP_PART=`expr $CURR_ROOT_PART + 1`
	SPAR_PSP_PART=`expr $SPAR_ROOT_PART + 1`

	CURR_BLR_DEV=$EMMC_DEV$CURR_BLR_PART
	SPAR_BLR_DEV=$EMMC_DEV$SPAR_BLR_PART
	CURR_SYS_DEV=$EMMC_DEV$CURR_ROOT_PART
	SPAR_SYS_DEV=$EMMC_DEV$SPAR_ROOT_PART
	CURR_PSP_DEV=$EMMC_DEV$CURR_PSP_PART
	SPAR_PSP_DEV=$EMMC_DEV$SPAR_PSP_PART

	echo "CURR_BLR_DEV="$CURR_BLR_DEV
	echo "CURR_SYS_DEV="$CURR_SYS_DEV
	echo "CURR_PSP_DEV="$CURR_PSP_DEV

	echo "SPAR_BLR_DEV="$SPAR_BLR_DEV
	echo "SPAR_SYS_DEV="$SPAR_SYS_DEV
	echo "SPAR_PSP_DEV="$SPAR_PSP_DEV
}


if [ $1 == "preinst" ]; then

	get_current_root_device
	get_update_part

	# format the device to be updated
	#/etc/init.d/S92oam stop
	#umount -f $CURR_OAM_DEV

	# create a symlink for the update process
	ln -sf $CURR_BLR_DEV /dev/boot_update_node
	echo "preinst done"

fi

if [ $1 == "postinst" ]; then

	#get_current_root_device
	#get_update_part
	echo "postinst done"
	echo "Please reboot manually"
	#switch_slot $SPAR_SLOT
	#check_slot
	#reboot
	#mount -t ext4 $CURR_OAM_DEV /oam

	#/etc/init.d/S92oam start

fi

