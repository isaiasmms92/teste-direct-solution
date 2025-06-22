import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';

class Mask {
  static final cpf = MaskedInputFormatter('###.###.###-##',
      allowedCharMatcher: RegExp('[0-9]'));
}
