class ApiResponse<T> {
  final bool ok;
  final String? msg;
  final T? result;

  ApiResponse.ok(this.result)
      : ok = true,
        msg = null;

  ApiResponse.error(this.msg)
      : ok = false,
        result = null;
}
