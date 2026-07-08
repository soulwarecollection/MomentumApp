sealed class Failure {
  const Failure({required this.message});

  final String message;
}

final class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

final class NetworkFailure extends Failure {
  const NetworkFailure({required super.message});
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure({required super.message});
}

final class ValidationFailure extends Failure {
  const ValidationFailure({required super.message});
}

final class UnexpectedFailure extends Failure {
  const UnexpectedFailure({required super.message});
}
