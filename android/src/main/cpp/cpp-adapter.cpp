#include <jni.h>
#include "rnsimaapptoappOnLoad.hpp"

JNIEXPORT jint JNICALL JNI_OnLoad(JavaVM* vm, void*) {
  return margelo::nitro::rnsimaapptoapp::initialize(vm);
}
