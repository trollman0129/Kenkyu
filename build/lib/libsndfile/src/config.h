#ifndef _SF_CONFIG_H
#define _SF_CONFIG_H

/* Manually generated config.h for Windows builds */

#define LIBSNDFILE_MAJOR_VERSION 1
#define LIBSNDFILE_MINOR_VERSION 2
#define LIBSNDFILE_MICRO_VERSION 2

#define PACKAGE_NAME "libsndfile"
#define VERSION "1.2.2" /* Adjust version based on your downloaded libsndfile */

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
