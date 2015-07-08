include theos/makefiles/common.mk

TWEAK_NAME = CustomFlash
CustomFlash_FILES = Tweak.xm
CustomFlash_FRAMEWORKS = UIKit

export ARCHS = armv7 arm64

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
