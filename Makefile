HOST_ARCH       ?= $(shell uname -m | sed -e s/arm.*/arm/ -e s/aarch64.*/arm64/)
ARCH            ?= $(shell uname -m | sed -e s/arm.*/arm/ -e s/aarch64.*/arm64/)
KERNEL_SRC  ?= /lib/modules/$(shell uname -r)/build

ifeq ($(ARCH), arm)
 ifneq ($(HOST_ARCH), arm)
   CROSS_COMPILE  ?= arm-linux-gnueabihf-
 endif
endif
ifeq ($(ARCH), arm64)
 ifneq ($(HOST_ARCH), arm64)
   CROSS_COMPILE  ?= aarch64-linux-gnu-
 endif
endif

obj-m := udmabuf.o

all:
	make -C $(KERNEL_SRC) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) M=$(PWD) modules

modules_install:
	make -C $(KERNEL_SRC) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) M=$(PWD) modules_install

clean:
	make -C $(KERNEL_SRC) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) M=$(PWD) clean

