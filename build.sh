#!/bin/bash

#
# Default variables
#
MODEL=5
DEBUG=0
TFA_FLAGS=""
EDK2_FLAGS="-t GCC5"

print_usage() {
    echo
    echo "Build TF-A + EDK2 image for Raspberry Pi."
    echo
    echo "Usage: build.sh [options]"
    echo
    echo "Options: "
    echo "  --model MODEL               Board family. Supported: 4, 5. Default: ${MODEL}."
    echo "  --debug DEBUG               Build a debug version. Default: ${DEBUG}."
    echo "  --tfa-flags \"FLAGS\"         Flags appended to TF-A build process."
    echo "  --edk2-flags \"FLAGS\"        Flags appended to EDK2 build process."
    echo "  --help                      Show this help."
    echo
    exit "${1}"
}

#
# Get machine architecture
#
MACHINE_TYPE=$(uname -m)

# Fix-up possible differences in reported arch
if [ ${MACHINE_TYPE} == 'arm64' ]; then
    MACHINE_TYPE='aarch64'
elif [ ${MACHINE_TYPE} == 'amd64' ]; then
    MACHINE_TYPE='x86_64'
fi

export CROSS_COMPILE=/usr/local/bin/aarch64-linux-gnueabihf-
export GCC5_AARCH64_PREFIX=/usr/local/bin/aarch64-linux-gnueabihf-

#
# Build TF-A
#
pushd arm-trusted-firmware || exit

make \
    PLAT=rpi${MODEL} \
    PRELOADED_BL33_BASE=0x20000 \
    RPI3_PRELOADED_DTB_BASE=0x3E0000 \
    SUPPORT_VFP=1 \
    SMC_PCI_SUPPORT=1 \
    ENABLE_FEAT_VHE=1 \
    DEBUG=${DEBUG} \
    all \
    ${TFA_FLAGS} \
    || exit

popd || exit

#
# Build EDK2 final image
#
GIT_COMMIT="$(git describe --tags --always)" || GIT_COMMIT="unknown"

if [ ${DEBUG} == 1 ]; then
    RELEASE_TYPE="DEBUG"
else
    RELEASE_TYPE="RELEASE"
fi

ATF_BUILD_DIR="${PWD}/arm-trusted-firmware/build/rpi${MODEL}/release"

export GCC_AARCH64_PREFIX="${CROSS_COMPILE}"
export WORKSPACE=${PWD}
export PACKAGES_PATH=${WORKSPACE}/edk2:${WORKSPACE}/edk2-platforms:${WORKSPACE}/edk2-non-osi

make -C ${WORKSPACE}/edk2/BaseTools || exit

source ${WORKSPACE}/edk2/edksetup.sh || exit

build \
    -a AARCH64 \
    -t GCC \
    -b ${RELEASE_TYPE} \
    -p edk2-platforms/Platform/RaspberryPi/RPi${MODEL}/RPi${MODEL}.dsc \
    -D TFA_BUILD_ARTIFACTS=${ATF_BUILD_DIR} \
    --pcd gEfiMdeModulePkgTokenSpaceGuid.PcdFirmwareVersionString=L"${GIT_COMMIT}" \
    ${EDK2_FLAGS} \
    || exit

cp ${WORKSPACE}/Build/RPi${MODEL}/${RELEASE_TYPE}_GCC/FV/RPI_EFI.fd ${PWD}
