export QT_STYLE_OVERRIDE=gtk2
export QT_QPA_PLATFORMTHEME=qt5ct


# https://stackoverflow.com/questions/47345147/android-sdk-manager-throw-exception-with-java-9
# export JAVA_OPTS='--add-modules java.xml.bind'

# android ndk installed via android studio
# note other paths/env vars added via android-.*-dummy aur packages
# https://aur.archlinux.org/cgit/aur.git/tree/android-ndk.sh?h=android-ndk
export PATH=$PATH:/opt/android-sdk/ndk-bundle
export ANDROID_NDK=/opt/android-sdk/ndk-bundle
# Some programs such as gradle ask this as well:
export ANDROID_NDK_HOME=/opt/android-sdk/ndk-bundle


export PATH=/home/stephen/bin:$PATH
