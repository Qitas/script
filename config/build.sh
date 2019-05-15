#!/bin/bash
set -e

export ROOT=`pwd`
SCRIPTS=$ROOT/scripts
export BOOT_PATH
export ROOTFS_PATH
export UBOOT_PATH

function git_configure()
{
    export GIT_CURL_VERBOSE=1
    export GIT_TRACE_PACKET=1
    export GIT_TRACE=1    
}


if [ -z $TOP_ROOT ]; then
    TOP_ROOT=`pwd`
fi

toolchain="https://codeload.github.com/sochub/arm-eabi/zip/master"

function install_toolchain()
{
    if [ ! -d $TOP_ROOT/toolchain/arm-eabi]; then
        mkdir -p $TOP_ROOT/.tmp_toolchain
        cd $TOP_ROOT/.tmp_toolchain
        curl -C - -o ./toolchain $toolchain
        unzip $TOP_ROOT/.tmp_toolchain/toolchain
        mkdir -p $TOP_ROOT/toolchain
        mv $TOP_ROOT/.tmp_toolchain/arm-eabi-master/gcc-arm-eabi/* $TOP_ROOT/toolchain/
        sudo chmod 755 $TOP_ROOT/toolchain -R
        rm -rf $TOP_ROOT/.tmp_toolchain
        cd -
    fi
} 

git_configure
install_toolchain

root_check()
{
	if [ "$(id -u)" -ne "0" ]; then
		echo "This option requires root."
		echo "Pls use command: sudo ./build.sh"
		exit 0
	fi	
}

UBOOT_check()
{
	for ((i = 0; i < 5; i++)); do
		UBOOT_PATH=$(whiptail --title "  Build System" \
			--inputbox "Pls input device node of SDcard.(/dev/sdc)" \
			10 60 3>&1 1>&2 2>&3)
	
		if [ $i = "4" ]; then
			whiptail --title "  Build System" --msgbox "Error, Invalid Path" 10 40 0	
			exit 0
		fi


		if [ ! -b "$UBOOT_PATH" ]; then
			whiptail --title "  Build System" --msgbox \
				"The input path invalid! Pls input correct path!" \
				--ok-button Continue 10 40 0	
		else
			i=200 
		fi 
	done
}

BOOT_check()
{
	## Get mount path of u-disk
	for ((i = 0; i < 5; i++)); do
		BOOT_PATH=$(whiptail --title "  Build System" \
			--inputbox "Pls input mount path of BOOT.(/media/ /BOOT)" \
			10 60 3>&1 1>&2 2>&3)
	
		if [ $i = "4" ]; then
			whiptail --title "  Build System" --msgbox "Error, Invalid Path" 10 40 0	
			exit 0
		fi


		if [ ! -d "$BOOT_PATH" ]; then
			whiptail --title "  Build System" --msgbox \
				"The input path invalid! Pls input correct path!" \
				--ok-button Continue 10 40 0	
		else
			i=200 
		fi 
	done
}

ROOTFS_check()
{
	for ((i = 0; i < 5; i++)); do
		ROOTFS_PATH=$(whiptail --title "  Build System" \
			--inputbox "Pls input mount path of rootfs.(/media/ /rootfs)" \
			10 60 3>&1 1>&2 2>&3)
	
		if [ $i = "4" ]; then
			whiptail --title "  Build System" --msgbox "Error, Invalid Path" 10 40 0	
			exit 0
		fi


		if [ ! -d "$ROOTFS_PATH" ]; then
			whiptail --title "  Build System" --msgbox \
				"The input path invalid! Pls input correct path!" \
				--ok-button Continue 10 40 0	
		else
			i=200 
		fi 
	done
}

Update_check()
{
	MENUSTR="Pls choose SD or EMMC"
	Target=$(whiptail --title "Build System" \
    	--menu "$MENUSTR" 10 60 3 --cancel-button Exit --ok-button Select \
    	"0"  "SD Card" \
    	"1"  "EMMC" \
    	3>&1 1>&2 2>&3)
}


MENUSTR="Welcome to Build System. Pls choose Platform."
##########################################
OPTION=$(whiptail --title "  4G-iot Build System" \
	--menu "$MENUSTR" 10 60 3 --cancel-button Exit --ok-button Select \
	"0"  "  4G-iot" \
	3>&1 1>&2 2>&3)

if [ $OPTION = "0" ]; then
	export PLATFORM="4g-iot"
else
	echo -e "\e[1;31m Pls select correct platform \e[0m"
	exit 0
fi

##########################################
## Root Password check
for ((i = 0; i < 5; i++)); do
	PASSWD=$(whiptail --title "Build System" \
		--passwordbox "Enter your root password. Note! Don't use root to run this scripts" \
		10 60 3>&1 1>&2 2>&3)
	
	if [ $i = "4" ]; then
		whiptail --title "Note Box" --msgbox "Error, Invalid password" 10 40 0	
		exit 0
	fi

	sudo -k
	if sudo -lS &> /dev/null << EOF
$PASSWD
EOF
	then
		i=10
	else
		whiptail --title "  Build System" --msgbox "Invalid password, Pls input corrent password" \
			10 40 0	--cancel-button Exit --ok-button Retry
	fi
done

echo $PASSWD | sudo ls &> /dev/null 2>&1

## Check cross tools
if [ ! -d $ROOT/toolchain/gcc-linaro-aarch -o ! -d $ROOT/toolchain/gcc-linaro-aarch/gcc-linaro/arm-linux-gnueabi ]; then
	cd $SCRIPTS
#	./install_toolchain.sh
	cd -
fi

if [ ! -d $ROOT/output ]; then
    mkdir -p $ROOT/output
fi

## prepare development tools
if [ ! -f $ROOT/output/.tmp_toolchain ]; then
	cd $SCRIPTS
	sudo ./Prepare_toolchain.sh
	touch $ROOT/output/.tmp_toolchain
	cd -
fi

MENUSTR="Pls select build option"

OPTION=$(whiptail --title "Build System" \
	--menu "$MENUSTR" 20 60 12 --cancel-button Finish --ok-button Select \
	"0"   "Build Release Image" \
	"1"   "Build LK" \
	"2"   "Build Linux" \
	"3"   "Install Image into EMMC" \
	3>&1 1>&2 2>&3)

if [ $OPTION = "0" -o $OPTION = "0" ]; then
	sudo echo ""
	clear
	exit 0
elif [ $OPTION = "1" ]; then
	cd $SCRIPTS

	clear
	exit 0
elif [ $OPTION = "2" ]; then
	export BUILD_KERNEL=1
	export BUILD_MODULE=1
	cd $SCRIPTS
	./kernel_compile.sh $PLATFORM
	clear
	exit 0
elif [ $OPTION = "10" ]; then
	export BUILD_KERNEL=1
	cd $SCRIPTS
	./kernel_compile.sh
	exit 0
elif [ $OPTION = "10" ]; then
	export BUILD_MODULE=1
	cd $SCRIPTS
	./kernel_compile.sh
	exit 0
elif [ $OPTION = "10" ]; then
	sudo echo ""
	clear
	UBOOT_check
	clear
	whiptail --title "  Build System" \
			 --msgbox "Burning Image to SDcard. Pls select Continue button" \
				10 40 0	--ok-button Continue
	pv "$ROOT/output/${PLATFORM}.img" | sudo dd bs=1M of=$UBOOT_PATH && sync
	clear
	whiptail --title "  Build System" --msgbox "Succeed to Download Image into SDcard" \
				10 40 0	--ok-button Continue
	exit 0
elif [ $OPTION = '11' ]; then
	clear 
	Update_check
	clear
	if [ $Target = "11" ]; then
		UBOOT_check
	fi
	clear
	cd $SCRIPTS
	sudo ./kernel_update.sh $UBOOT_PATH  #$PLATFORM
	exit 0
elif [ $OPTION = "11" ]; then
	sudo echo ""
	clear 
	ROOTFS_check
	clear
	cd $SCRIPTS
	sudo ./modules_update.sh $ROOTFS_PATH
	exit 0
elif [ $OPTION = "11" ]; then
	clear
	Update_check
	clear
	if [ $Target = "0" ]; then
		UBOOT_check
	fi
	clear
	cd $SCRIPTS
	sudo ./uboot_update.sh $UBOOT_PATH
	exit 0
elif [ $OPTION = '3' ]; then
	clear
	cd $ROOT/external/SP_Flash_Tool_v5.1644_Linux
	sudo ./flash_tool.sh 
	cd -
	exit 0
elif [ $OPTION = '4' ]; then
	clear 
#	Update_check
#	clear
	cd $SCRIPTS
	sudo ./build_system.sh
	exit 0
else
	whiptail --title "Build System" \
		--msgbox "Pls select correct option" 10 50 0
	exit 0
fi
