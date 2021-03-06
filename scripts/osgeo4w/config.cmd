@echo off

:: This configure script is designed for the default Windows world, which means
:: you have OSGeo4W installed, including Oracle and GDAL and LASzip.

:: This configure script expects to be run from the PDAL root directory.

:: Pick your CMake GENERATOR.  (NMake will pick up architecture (x32, x64) from your environment)
REM set GENERATOR="Visual Studio 14 2015 Win64"
set GENERATOR="NMake Makefiles"
REM set GENERATOR="Ninja"
REM set GENERATOR="Visual Studio 14 Win64"


REM set BUILD_TYPE=Debug

:: Where is your PDAL build tree?
set PDAL_DIR=%~dp0

:: Where is your OSGeo4W installed (recommended basic way to satisfy dependent libs)
set OSGEO4W_DIR=C:/OSGeo4W64


if EXIST CMakeCache.txt del CMakeCache.txt
del /s /q CMakeFiles
del /s /q install

cmake -G %GENERATOR% ^
    -DBUILD_PLUGIN_CPD=OFF ^
    -DBUILD_PLUGIN_GREYHOUND=ON ^
    -DBUILD_PLUGIN_HEXBIN=ON ^
    -DBUILD_PLUGIN_ICEBRIDGE=OFF ^
    -DBUILD_PLUGIN_MRSID=OFF ^
    -DBUILD_PLUGIN_NITF=ON ^
    -DBUILD_PLUGIN_OCI=ON ^
    -DBUILD_PLUGIN_PCL=OFF ^
    -DBUILD_PLUGIN_PGPOINTCLOUD=ON ^
    -DBUILD_PLUGIN_SQLITE=ON ^
    -DBUILD_PLUGIN_RIVLIB=OFF ^
    -DBUILD_PLUGIN_PYTHON=ON ^
    -DENABLE_CTEST=OFF ^
    -DWITH_LAZPERF=ON ^
	-DLazperf_DIR=%OSGEO4W_DIR% ^
    -DWITH_LASZIP=ON ^
    -DWITH_TESTS=ON ^
	-DPDAL_PLUGIN_INSTALL_PATH=C:/OSGeo4W64/bin ^
	-DGDAL_INCLUDE_DIR=%OSGEO4W_DIR%/apps/gdal-dev/include ^
	-DGDAL_LIBRARY=%OSGEO4W_DIR%/apps/gdal-dev/lib/gdal_i.lib ^
	-DPYTHON_EXECUTABLE=%OSGEO4W_DIR%/apps/python36/python.exe ^
	-DPYTHON_INCLUDE_DIR=%OSGEO4W_DIR%/apps/python36/include ^
	-DPYTHON_LIBRARY=%OSGEO4W_DIR%/apps/python36/libs/python36.lib ^
	-DPYTHON_DEBUG_LIBRARY=%OSGEO4W_DIR%/apps/python36/libs/python36.lib ^
	-DORACLE_INCLUDE_DIR=%OSGEO4W_DIR%/include ^
	-DORACLE_LIBRARY=%OSGEO4W_DIR%/lib/oci.lib ^
	-DCURL_INCLUDE_DIR=%OSGEO4W_DIR%/include ^
	-DCURL_LIBRARY=%OSGEO4W_DIR%/lib/libcurl.lib ^
	-DNUMPY_INCLUDE_DIR=%OSGEO4W_DIR%/apps/python36/lib/site-packages/numpy/core/include ^
	-DNUMPY_VERSION=1.12.0 ^
    -Dgtest_force_shared_crt=ON ^
    -DCMAKE_INSTALL_PREFIX=%PDAL_DIR%/install ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_VERBOSE_MAKEFILE=OFF ^
    .

REM ninja
REM ninja install
REM set PATH=%PATH%;%OSGEO4W_DIR%/apps/msys/bin
REM cd %PDAL_DIR%\install
REM echo %cd%
REM %OSGEO4W_DIR%/apps/msys/bin/tar jcvf ../pdal-1.5.0-3.tar.bz2 .
REM cd %PDAL_DIR%
