import 'dart:collection';

mixin AdditionalConsumerDataRequestMixin on UnmodifiableMapBase<int, String> {
  /// Additional information to assist with the transaction completion.
  ///
  /// Example use case, such as providing a flag indicating that the user has to
  /// provide the mobile number of current payment device, and if necessary,
  /// provides it automatically for convenience.
  ///
  /// The information is obtained within ID "09", if available. Expected a [String]
  /// that contains letter A, M, or E, where each letter represents a requirement
  /// for a certain information from the consumer.
  /// - **A** stands for Address Requirement
  /// - **M** stands for Phone Requirement
  /// - **E** stands for Email Requirement
  String? get additionalConsumerDataRequest => this[9];

  final Map<String, bool> _consumerFlags = {};

  bool _checkAndAssignFlag(
    String flag,
  ) {
    var flags = _consumerFlags[flag];
    flags ??= additionalConsumerDataRequest?.contains(
          flag,
        ) ??
        false;
    _consumerFlags[flag] ??= flags;
    return flags;
  }

  bool get consumerAddressRequired => _checkAndAssignFlag(
        'A',
      );

  bool get consumerPhoneRequired => _checkAndAssignFlag(
        'M',
      );

  bool get consumerEmailRequired => _checkAndAssignFlag(
        'E',
      );
}
