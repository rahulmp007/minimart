import 'package:minimart/src/core/error/value_failure.dart';
import 'package:minimart/src/features/auth/domain/value_objects/password.dart';
import 'package:minimart/src/features/auth/domain/value_objects/email_address.dart';
import 'package:minimart/src/features/auth/domain/value_objects/name.dart';

String? mapPasswordError(Password? password) {
  return password?.value.fold((failure) {
    if (failure is Empty) return "Password is required";
    if (failure is ShortPassword) {
      return "Password must be at least 6 characters";
    }
    if (failure is MissingNumber) {
      return "Password must contain a number";
    }
    return "Invalid password";
  }, (_) => null);
}

String? mapEmailError(EmailAddress? email) {
  return email?.value.fold((failure) => "Invalid email format", (_) => null);
}

String? mapNameError(Name? name) {
  return name?.value.fold(
    (failure) => "Name must be at least 2 characters",
    (_) => null,
  );
}
