// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:assets/assets.dart';

Future<void> main() async {
  final awesome = const StringAsset('testKey');
  print('awesome: ${await awesome.load()}');
}
