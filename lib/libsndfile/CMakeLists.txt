# lib/libsndfile/CMakeLists.txt の最終修正案 (Windows用)
# この内容でファイルを丸ごと上書きしてください。

cmake_minimum_required (VERSION 3.10) # 最新のCMakeの推奨バージョンに更新

project (libsndfile C) # C言語プロジェクトであることを明示

# ★★★ 必要な定義を手動で設定し、config.h を直接生成する ★★★
# CMAKE_BINARY_DIR の下に、libsndfileが期待するパスで config.h を生成します。
file(WRITE "${CMAKE_BINARY_DIR}/lib/libsndfile/src/config.h" "\
#ifndef _SF_CONFIG_H
#define _SF_CONFIG_H

/* Manually generated config.h for Windows builds */

#define LIBSNDFILE_MAJOR_VERSION 1
#define LIBSNDFILE_MINOR_VERSION 2
#define LIBSNDFILE_MICRO_VERSION 2

#define PACKAGE_NAME \"libsndfile\"
#define VERSION \"1.2.2\" /* Adjust version based on your downloaded libsndfile */

// Standard C headers
#define HAVE_STDDEF_H 1
#define HAVE_STDINT_H 1
#define HAVE_STDLIB_H 1
#define HAVE_STRING_H 1
#define HAVE_UNISTD_H 0 // <--- CRITICAL: UNISTD.H is NOT available on Windows MSVC

// System specific headers & features (adjust as needed for your Windows setup)
#define HAVE_SNPRINTF 1
#define snprintf _snprintf // MSVC compatibility for snprintf
#define HAVE_STRNCPY 1
#define HAVE_STRCHR 1
#define HAVE_STRRCHR 1
#define HAVE_STRSTR 1
#define HAVE_MEMSET 1
#define HAVE_MEMCPY 1
#define HAVE_MEMMOVE 1
#define HAVE_REALPATH 0
#define HAVE_GETCWD 1
#define HAVE_GETTIMEOFDAY 0 // Windows equivalent is GetSystemTimeAsFileTime or similar
#define HAVE_FSEEKO 1 // On Windows, _fseeki64 usually handles large files
#define HAVE_FTELLO 1 // On Windows, _ftelli64 usually handles large files
#define HAVE_LARGE_FILE_SUPPORT 1
#define HAVE_MMAP 0 // No mmap on Windows (usually)
#define HAVE_DLFCN_H 0 // No dlfcn.h on Windows

// Additional common definitions that might be expected by libsndfile sources
#define _POSIX_SOURCE 1 // Many libsndfile files use POSIX features, define this for compatibility (even if some things are disabled)
#define HAVE_SYS_TYPES_H 1
#define HAVE_SYS_STAT_H 1
#define HAVE_SYS_MMAN_H 0
#define HAVE_IO_H 1 // For Windows specific headers like _read, _write etc.

#define ENABLE_EXPERIMENTAL_CODE 0
#define CPU_CLIPS_POSITIVE 0
#define CPU_CLIPS_NEGATIVE 0

#ifdef _WIN32
#define __S_IFMT 0x0000FFFF // dummy value for compatibility
#define __S_IFREG 0x8000 // dummy value for compatibility
#define __S_IFDIR 0x4000 // dummy value for compatibility
#endif

#endif // _SF_CONFIG_H
")

# sndfile.h をビルドディレクトリに出力するように修正
configure_file (${CMAKE_SOURCE_DIR}/src/sndfile.h.in "${CMAKE_BINARY_DIR}/lib/libsndfile/src/sndfile.h")

# ★★★ 不要な include や検出、ビルドの無効化 ★★★
# 元々あった find_program や execute_process は全て不要
# include (CMake/file.cmake) # 不要
# include (CMake/autogen.cmake) # 不要
# include (CMake/build.cmake) # 不要
# include (CMake/external_libs.cmake) # 不要
# include (CMake/libsndfile.cmake) # 不要

# LIB_VERSIONはすでに手動でセット済み
set (VERSION "${LIB_VERSION}")
set (PACKAGE_VERSION "${LIB_VERSION}")
set (PACKAGE "libsndfile")
set (PACKAGE_NAME "libsndfile")
set (BASEPATH "${CMAKE_SOURCE_DIR}")

# MSVCコンパイラ向けのフラグ設定（元のCMakeLists.txtから引用）
if (CMAKE_C_COMPILER_ID STREQUAL "MSVC")
	set (CMAKE_C_FLAGS "${CMAKE_CXX_FLAGS} /wd4244 /wd4996" CACHE STRING "" FORCE)
	add_definitions ("/wd4244 /wd4996")
endif ()

# 基本的なインクルードディレクトリの追加
include_directories (src) # libsndfile/src/ をインクルード
include_directories (inc) # libsndfile/inc/ をインクルード

# ★★★ コアライブラリのソースファイルリスト ★★★
# テストファイルやOS固有でないファイルはコメントアウト
set (libsndfile_sources
	src/ALAC/ALACBitUtilities.c
	src/ALAC/ag_dec.c
	src/ALAC/ag_enc.c
	src/ALAC/alac_decoder.c
	src/ALAC/alac_encoder.c
	src/ALAC/dp_dec.c
	src/ALAC/dp_enc.c
	src/ALAC/matrix_dec.c
	src/ALAC/matrix_enc.c

	src/G72x/g721.c
	src/G72x/g723_16.c
	src/G72x/g723_24.c
	src/G72x/g723_40.c
	src/G72x/g72x.c
	# src/G72x/g72x_test.c # テストファイルなのでコメントアウト
	src/GSM610/add.c
	src/GSM610/code.c
	src/GSM610/decode.c
	src/GSM610/gsm_create.c
	src/GSM610/gsm_decode.c
	src/GSM610/gsm_destroy.c
	src/GSM610/gsm_encode.c
	src/GSM610/gsm_option.c
	src/GSM610/long_term.c
	src/GSM610/lpc.c
	src/GSM610/preprocess.c
	src/GSM610/rpe.c
	src/GSM610/short_term.c
	src/GSM610/table.c

	src/aiff.c
	src/alac.c
	src/alaw.c
	src/au.c
	src/audio_detect.c
	src/avr.c
	src/broadcast.c
	src/caf.c
	src/cart.c
	src/chanmap.c
	src/chunk.c
	src/command.c
	src/common.c
	src/dither.c
	src/double64.c
	src/dwd.c
	src/dwvw.c
	src/file_io.c
	src/flac.c
	src/float32.c
	src/g72x.c
	src/gsm610.c
	src/htk.c
	src/id3.c
	src/ima_adpcm.c
	src/ima_oki_adpcm.c
	src/interleave.c
	src/ircam.c
	# src/macos.c # MacOS特有なのでコメントアウト
	src/mat4.c
	src/mat5.c
	src/mpc2k.c
	src/ms_adpcm.c
	src/nist.c
	src/ogg.c
	src/ogg_opus.c
	src/ogg_pcm.c
	src/ogg_speex.c
	src/ogg_vorbis.c
	src/paf.c
	src/pcm.c
	src/pvf.c
	src/raw.c
	src/rf64.c
	src/rx2.c
	src/sd2.c
	src/sds.c
	src/sndfile.c
	src/strings.c
	src/svx.c
	src/txw.c
	src/ulaw.c
	src/voc.c
	src/vox_adpcm.c
	src/w64.c
	src/wav.c
	src/wavlike.c
	src/windows.c # Windows特有なので残す
	src/wve.c
	src/xi.c
	)

add_library (sndfile SHARED
	${libsndfile_sources}
	)

# リンカーフラグを調整
# 'm' はLinuxの数学ライブラリなのでWindowsでは不要。
# external_libs.cmake がインクルードされていないため、EXTERNAL_XIPH_LIBS も未定義。
target_link_libraries (sndfile ) # 必要であれば後で他のライブラリを追加 (例: ogg, vorbis, flacなど)

set_target_properties (sndfile
	PROPERTIES
	VERSION ${LIB_VERSION}
	SOVERSION ${LIB_VERSION_MAJOR}
	# 出力ディレクトリをビルドディレクトリ内の lib/libsndfile/src から、
	# あなたのプロジェクトのビルド出力ディレクトリに変更します。
	# これにより、dll が main.exe と同じ build/bin/Debug に配置されます。
	LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin/${CMAKE_BUILD_TYPE}"
	RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin/${CMAKE_BUILD_TYPE}"
	ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib/${CMAKE_BUILD_TYPE}"
	)

#-------------------------------------------------------------------------------
# Programs. (全てコメントアウトする)
# lsf_build_program, lsf_build_program_extra の呼び出しは全てコメントアウト済みであることを確認。

#-------------------------------------------------------------------------------
# Tests. (全てコメントアウトする)
# configure_file (...sh.in) や add_custom_target (check) など、全てのテスト関連のコマンドはコメントアウト済みであることを確認。
# lsf_build_src_test_c, lsf_build_test_c, lsf_build_test_cc の呼び出しも全てコメントアウト済みであることを確認。