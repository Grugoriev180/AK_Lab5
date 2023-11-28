
ifneq ($(KERNELRELEASE),)
	obj-m := helloL5.o
	ccflags-y += -g -DDEBUG
else
	KDIR ?= /lib/modules/`uname -r`/build

default:
	$(MAKE) -C $(KDIR) M=$$PWD
	cp helloL5.ko helloL5.ko.unstripped
	$(CROSS_COMPILE)strip -g helloL5.ko
clean:
	$(MAKE) -C $(KDIR) M=$$PWD clean
%.s %.i: %.c
	$(MAKE) -C $(KDIR) M=$$PWD $@
endif
