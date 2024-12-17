// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart' show immutable;

typedef CloseLoadingScreen = bool Function();

@immutable
class LoadingScreenController {
  final CloseLoadingScreen close; // to closs our dialog

  const LoadingScreenController({
    required this.close,
  });
}