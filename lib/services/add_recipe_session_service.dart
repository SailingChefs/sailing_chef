import 'package:flutter/foundation.dart';

class AddRecipeSessionService {
  bool Function()? _hasPendingChangesProvider;
  Map<String, dynamic> Function()? _dialogDataProvider;

  void registerSession({
    required bool Function() hasPendingChangesProvider,
    required Map<String, dynamic> Function() dialogDataProvider,
  }) {
    _hasPendingChangesProvider = hasPendingChangesProvider;
    _dialogDataProvider = dialogDataProvider;
  }

  void clearSession() {
    _hasPendingChangesProvider = null;
    _dialogDataProvider = null;
  }

  bool get shouldPromptOnExit {
    return _hasPendingChangesProvider?.call() ?? false;
  }

  Map<String, dynamic>? getDialogData() {
    final provider = _dialogDataProvider;
    if (provider == null) {
      return null;
    }
    return provider();
  }

  @visibleForTesting
  bool get hasActiveSession => _dialogDataProvider != null;
}
