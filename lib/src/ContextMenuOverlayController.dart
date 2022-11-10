import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../context_menus.dart';

class ContextMenuOverlayController {
  late ContextMenuOverlayState state;

  void show(Widget menu){
    state?.show(menu);
  }

  void hide(){
    state?.hide();
  }

  static getShow(Widget menu , {String? tag}){
    if (!Get.isRegistered<ContextMenuOverlayController>(tag: tag)){
      return ;
    }
    ContextMenuOverlayController ctrl = Get.find<ContextMenuOverlayController>(tag:tag);
    ctrl.show(menu);
  }

  static void getHide({String? tag}){
    if (!Get.isRegistered<ContextMenuOverlayController>(tag: tag)){
      return ;
    }
    ContextMenuOverlayController ctrl = Get.find<ContextMenuOverlayController>(tag:tag);
    ctrl.hide();
  }
}

typedef CmoC = ContextMenuOverlayController;
