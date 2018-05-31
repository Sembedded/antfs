#
# Makefile for the AVM NTFS filesystem.
#

MODULE_PATH := fs/antfs
LIBNTFS_SRC := libntfs-3g

#check if we are on a shared or p branch

GIT_CMD := git -C $(srctree)/$(MODULE_PATH)
ifeq ($(shell $(GIT_CMD) rev-parse --abbrev-ref HEAD | grep -E "^(shared|p)\/"),)
#stable, branch or something else
EXTRA_CFLAGS += -DANTFS_LOGLEVEL_DEFAULT=ANTFS_LOGLEVEL_ERR
EXTRA_CFLAGS += -DANTFS_VERSION=\"$(shell $(GIT_CMD) describe --tags | grep -o '^[0-9.]*')\"
else
#shared/ or p/
EXTRA_CFLAGS += -DANTFS_LOGLEVEL_DEFAULT=ANTFS_LOGLEVEL_ERR_EXT
EXTRA_CFLAGS += -DANTFS_VERSION=\"$(shell $(GIT_CMD) rev-parse --short HEAD)\"
endif

EXTRA_CFLAGS += -I$(MODULE_PATH)
EXTRA_CFLAGS += -I$(MODULE_PATH)/include
#EXTRA_CFLAGS += -Wextra -Wshadow -Werror -Wno-error=shadow

obj-$(CONFIG_ANTFS_FS) += antfs.o

antfs-y := \
	dir.o \
	file.o \
	inode.o \
	super.o \
	$(LIBNTFS_SRC)/unistr.o \
	$(LIBNTFS_SRC)/inode.o \
	$(LIBNTFS_SRC)/device.o \
	$(LIBNTFS_SRC)/mft.o \
	$(LIBNTFS_SRC)/volume.o \
	$(LIBNTFS_SRC)/bootsect.o \
	$(LIBNTFS_SRC)/runlist.o \
	$(LIBNTFS_SRC)/linux_io.o \
	$(LIBNTFS_SRC)/dir.o \
	$(LIBNTFS_SRC)/collate.o \
	$(LIBNTFS_SRC)/lcnalloc.o \
	$(LIBNTFS_SRC)/object_id.o \
	$(LIBNTFS_SRC)/index.o \
	$(LIBNTFS_SRC)/cache.o \
	$(LIBNTFS_SRC)/attrlist.o \
	$(LIBNTFS_SRC)/attrib.o \
	$(LIBNTFS_SRC)/misc.o \
	$(LIBNTFS_SRC)/reparse.o \
	$(LIBNTFS_SRC)/logfile.o \
	$(LIBNTFS_SRC)/compress.o \
	$(LIBNTFS_SRC)/mst.o

