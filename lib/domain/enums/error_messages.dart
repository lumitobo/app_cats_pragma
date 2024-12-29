
enum ErrorMessages {

  serverError, responseNotMapped, emptyCache, unknowError;

  String get message {
    switch (this) {
      case ErrorMessages.serverError:
        return 'Server error.';
      case ErrorMessages.responseNotMapped:
        return 'Error mapping value. Invalid value.';
      case ErrorMessages.unknowError:
        return 'Unknow error';
      case ErrorMessages.emptyCache:
        return 'Cache is empty or unavailable.';
    }
  }
}


