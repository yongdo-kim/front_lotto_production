import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:yd_lotto_provider/lotto.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();
  runApp(LottoApp());
}

