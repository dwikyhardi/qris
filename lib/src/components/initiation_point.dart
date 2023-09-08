import 'dart:collection';

/// The description of the origin of the QRIS Code
enum InitiationPoint {
  /// The QRIS is static, usually printed physically around the merchant's
  /// vicinity.
  staticCode,

  /// The QRIS is dynamically generated, usually through smartphones/EDC devices
  /// from the merchant.
  dynamicCode,
}

extension InitiationPointUtils on InitiationPoint {
  int get code {
    switch (this) {
      case InitiationPoint.staticCode:
        return 11;
      case InitiationPoint.dynamicCode:
        return 12;
    }
  }
}

mixin QRISInitiationPoint on MapBase<int, String> {
  /// The Point of Initiation Method code. Indicates the origin of the QRIS Code.
  ///
  /// 11 indicates a static QRIS Code, usually the physically printed ones.
  /// 12 indicates a dynamically generated QRIS Code, usually generated by the
  /// merchant.
  InitiationPoint? get pointOfInitiation {
    switch (this[1]) {
      case '11':
        return InitiationPoint.staticCode;
      case '12':
        return InitiationPoint.dynamicCode;
    }
    return null;
  }

  /// Check if this QRIS is a Static QR Code
  bool get isStatic => this[1] == '11';

  /// Check if this QRIS is a Dynamic QR Code
  bool get isDynamic => this[1] == '12';
}
