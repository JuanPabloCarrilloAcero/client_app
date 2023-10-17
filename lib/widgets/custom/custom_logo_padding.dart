import 'package:flutter/cupertino.dart';

import '../../methods/isMobileOrDesktop.dart';

EdgeInsets getCustomPadding() {
  if (isMobileOrDesktop()) {
    return const EdgeInsets.only(top: 0.0);
  } else {
    return const EdgeInsets.only(top: 50.0);
  }
}