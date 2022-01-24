# dir
cd ~
mkdir rom
cd rom

# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Project-Xtended/manifest.git -b xs -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# Trees
git clone https://github.com/Subhendu-droid/device_asus_X01AD-1.git -b MSM device/asus/X01AD
git clone https://github.com/BCA-RMIT/vendor_asus_X01AD.git -b lineage-18.1 vendor/asus/X01AD
git clone https://github.com/Subhendu-droid/android_kernel_asus_X01AD.git -b lineage-18.1 kernel/asus/X01AD

# build rom
source build/envsetup.sh
lunch xtended_X01AD-userdebug
export ALLOW_MISSING_DEPENDENCIES=true
export TZ=Asia/Dhaka #put before last build command
mka bacon

# upload rom 
cd out/target/product/*
curl -sL https://git.io/file-transfer | sh 
./transfer wet *.zip
