cmake_minimum_required(VERSION 3.10)

project(BPMiku CXX) # CXX を指定してC++プロジェクトであることを明示

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if(CMAKE_BUILD_TYPE STREQUAL "Release")
    add_compile_options(-O3 -DNDEBUG)
elseif(CMAKE_BUILD_TYPE STREQUAL "Debug")
    add_compile_options(-g)
endif()

# ====================================================================
# 外部ライブラリの組み込み (add_subdirectory でソースからビルド)
# ====================================================================

# --- PortAudio の組み込み ---
add_subdirectory(lib/portaudio) # third_party から lib に変更
set(PORTAUDIO_TARGET portaudio_static) # 通常、PortAudioが提供する静的ライブラリ名

# --- libsndfile の組み込み ---
add_subdirectory(lib/libsndfile) # third_party から lib に変更
set(LIBSNDFILE_TARGET sndfile) # libsndfileのターゲット名

# --- SoundTouch の組み込み ---
# SoundTouchのソースコードがあるディレクトリを指定
set(SOUNDTOUCH_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/lib/soundtouch/source") # third_party から lib に変更

# SoundTouch のソースファイルをリストアップ
set(SOUNDTOUCH_SRCS
    ${SOUNDTOUCH_SOURCE_DIR}/AAFilter.cpp
    ${SOUNDTOUCH_SOURCE_DIR}/BPMDetect.cpp
    ${SOUNDTOUCH_SOURCE_DIR}/cpu_detect.cpp
    ${SOUNDTOUCH_SOURCE_DIR}/FIFOSampleBuffer.cpp
    ${SOUNDTOUCH_SOURCE_DIR}/PeakFinder.cpp
    ${SOUNDTOUCH_SOURCE_DIR}/RateTransposer.cpp
    ${SOUNDTOUCH_SOURCE_DIR}/SoundTouch.cpp
    ${SOUNDTOUCH_SOURCE_DIR}/TDStretch.cpp
    ${SOUNDTOUCH_SOURCE_DIR}/VSTypes.cpp # このファイルはバージョンによって存在しない場合があります。ビルドエラーが出たら削除してください。
)

# SoundTouch ライブラリを作成 (静的ライブラリとして)
add_library(soundtouch STATIC ${SOUNDTOUCH_SRCS})

# SoundTouchのヘッダーファイルパスを追加
target_include_directories(soundtouch PUBLIC
    ${SOUNDTOUCH_SOURCE_DIR}
)

# SoundTouchの最適化オプション (任意)
if(MSVC)
    target_compile_options(soundtouch PRIVATE "/arch:SSE2")
elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    target_compile_options(soundtouch PRIVATE -msse -msse2 -mfpmath=sse)
endif()


# ====================================================================
# あなたのアプリケーションの実行可能ファイルの定義
# ====================================================================

# 実行可能ファイルを作成。src/main.cpp がメインのソースファイルです。
add_executable(${PROJECT_NAME} src/main.cpp)

# あなたのプロジェクトのヘッダーファイルパスを追加 (もしinclude/ディレクトリがある場合)
target_include_directories(${PROJECT_NAME} PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include # あなたのカスタムヘッダーがあれば
)

# ====================================================================
# ライブラリのリンク (あなたのアプリケーションが依存するライブラリ)
# ====================================================================

# PortAudio, Libsndfile, SoundTouch の全てをあなたのアプリケーションにリンクします。
target_link_libraries(${PROJECT_NAME} PUBLIC
    ${PORTAUDIO_TARGET}
    ${LIBSNDFILE_TARGET}
    ${SOUNDTOUCH_TARGET} # SoundTouchライブラリのターゲット名
)

if(APPLE)
    target_link_libraries(${PROJECT_NAME} PUBLIC "-framework CoreAudio")
elseif(UNIX)
    find_package(PkgConfig QUIET)
    pkg_check_modules(ALSA QUIET alsa)
    if(ALSA_FOUND)
        target_link_libraries(${PROJECT_NAME} PUBLIC ${ALSA_LIBRARIES})
        target_include_directories(${PROJECT_NAME} PUBLIC ${ALSA_INCLUDE_DIRS})
    else()
        message(WARNING "ALSA development libraries not found. PortAudio might not function correctly on Linux.")
    endif()
    target_link_libraries(${PROJECT_NAME} PUBLIC m pthread)
elseif(WIN32)
    target_link_libraries(${PROJECT_NAME} PUBLIC
        winmm.lib
        setupapi.lib
        ole32.lib
        uuid.lib
    )
endif()

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin/${CMAKE_BUILD_TYPE}")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib/${CMAKE_BUILD_TYPE}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib/${CMAKE_BUILD_TYPE}")