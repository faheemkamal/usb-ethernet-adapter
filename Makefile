# This makefile for CH9X00 network adaptor
# Makefile for linux 2.6.x - 3.8.x

KVER := $(shell uname -r)
KSRC := /lib/modules/$(KVER)/build
MODULE_NAME = ch9200
MODDESTDIR := /lib/modules/$(KVER)/kernel/drivers/net/usb

ifneq ($(KERNELRELEASE), )
#call from kernel build system
obj-m := ch9200.o
else

	export CONFIG_USB_NET_CH9200 = m

PWD := $(shell pwd)

modules:
	$(MAKE) -C $(KSRC) M=$(PWD) modules
	
install:
	install -p -m 644 $(MODULE_NAME).ko $(MODDESTDIR)
	/sbin/depmod -a ${KVER}

uninstall:
	rm -f $(MODDESTDIR)/$(MODULE_NAME).ko
	/sbin/depmod -a ${KVER}

clean:
	rm -rf *.o *~ core .depend .*.cmd *.mod.c .tmp_versions modules.* Module*
	rm -rf *.ko

endif
