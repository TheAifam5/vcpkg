include(vcpkg_common_functions)

set(LIBPOPT_VERSION 1.16)
set(LIBPOPT_HASH bae2dd4e5d682ef023fdc77ae60c4aad01a3a576d45af9d78d22490c11e410e60edda37ede171920746d4ae0d5de3c060d15cecfd41ba75b727a811be828d694)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/popt-${LIBPOPT_VERSION})

vcpkg_download_distfile(ARCHIVE
    URLS
        "http://rpm5.org/files/popt/popt-${LIBPOPT_VERSION}.tar.gz"
        "https://ftp.openbsd.org/pub/OpenBSD/distfiles/popt-${LIBPOPT_VERSION}.tar.gz"
    FILENAME "popt-${LIBPOPT_VERSION}.tar.gz"
    SHA512 ${LIBPOPT_HASH}
)
vcpkg_extract_source_archive(${ARCHIVE})

vcpkg_apply_patches(
    SOURCE_PATH ${SOURCE_PATH}
    PATCHES "${CMAKE_CURRENT_LIST_DIR}/patches/0004-vcpkg-fixmsvc.patch"
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/cmake/CMakeLists.txt DESTINATION ${SOURCE_PATH})
file(COPY ${CMAKE_CURRENT_LIST_DIR}/cmake/config.h.cmake DESTINATION ${SOURCE_PATH})
file(COPY ${CMAKE_CURRENT_LIST_DIR}/cmake/popt.def       DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS -DPOPT_USE_CONFIG=1
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(COPY ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/libpopt)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/libpopt/COPYING ${CURRENT_PACKAGES_DIR}/share/libpopt/copyright)
