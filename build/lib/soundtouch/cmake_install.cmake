# Install script for directory: C:/kenkyu/Kenkyu/lib/soundtouch

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "C:/Program Files (x86)/BPMiku")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set path to fallback-tool for dependency-resolution.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "C:/mingw64/bin/objdump.exe")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "SoundTouch" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/soundtouch" TYPE FILE FILES
    "C:/kenkyu/Kenkyu/lib/soundtouch/include/BPMDetect.h"
    "C:/kenkyu/Kenkyu/lib/soundtouch/include/FIFOSampleBuffer.h"
    "C:/kenkyu/Kenkyu/lib/soundtouch/include/FIFOSamplePipe.h"
    "C:/kenkyu/Kenkyu/lib/soundtouch/include/STTypes.h"
    "C:/kenkyu/Kenkyu/lib/soundtouch/include/SoundTouch.h"
    "C:/kenkyu/Kenkyu/lib/soundtouch/include/soundtouch_config.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "C:/kenkyu/Kenkyu/build/lib/soundtouch/libSoundTouch.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "soundstretch" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "C:/kenkyu/Kenkyu/build/lib/soundtouch/soundstretch.exe")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/soundstretch.exe" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/soundstretch.exe")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "C:/mingw64/bin/strip.exe" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/soundstretch.exe")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "soundstretch" OR NOT CMAKE_INSTALL_COMPONENT)
  include("C:/kenkyu/Kenkyu/build/lib/soundtouch/CMakeFiles/soundstretch.dir/install-cxx-module-bmi-Debug.cmake" OPTIONAL)
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "SoundTouch" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "C:/kenkyu/Kenkyu/build/lib/soundtouch/soundtouch.pc")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "SoundTouch" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/SoundTouch/SoundTouchTargets.cmake")
    file(DIFFERENT _cmake_export_file_changed FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/SoundTouch/SoundTouchTargets.cmake"
         "C:/kenkyu/Kenkyu/build/lib/soundtouch/CMakeFiles/Export/fa99ba0aecbeab0836538d30f1ae2cb3/SoundTouchTargets.cmake")
    if(_cmake_export_file_changed)
      file(GLOB _cmake_old_config_files "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/SoundTouch/SoundTouchTargets-*.cmake")
      if(_cmake_old_config_files)
        string(REPLACE ";" ", " _cmake_old_config_files_text "${_cmake_old_config_files}")
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/SoundTouch/SoundTouchTargets.cmake\" will be replaced.  Removing files [${_cmake_old_config_files_text}].")
        unset(_cmake_old_config_files_text)
        file(REMOVE ${_cmake_old_config_files})
      endif()
      unset(_cmake_old_config_files)
    endif()
    unset(_cmake_export_file_changed)
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/SoundTouch" TYPE FILE FILES "C:/kenkyu/Kenkyu/build/lib/soundtouch/CMakeFiles/Export/fa99ba0aecbeab0836538d30f1ae2cb3/SoundTouchTargets.cmake")
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/SoundTouch" TYPE FILE FILES "C:/kenkyu/Kenkyu/build/lib/soundtouch/CMakeFiles/Export/fa99ba0aecbeab0836538d30f1ae2cb3/SoundTouchTargets-debug.cmake")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "SoundTouch" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/SoundTouch" TYPE FILE FILES
    "C:/kenkyu/Kenkyu/build/lib/soundtouch/SoundTouchConfig.cmake"
    "C:/kenkyu/Kenkyu/build/lib/soundtouch/SoundTouchConfigVersion.cmake"
    )
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "C:/kenkyu/Kenkyu/build/lib/soundtouch/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
