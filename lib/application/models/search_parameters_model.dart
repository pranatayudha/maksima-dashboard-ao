class SearchParametersModel {
  SearchParametersModel({
    required this.name,
    required this.page,
    required this.limit,
    required this.status,
    required this.loanTypeId,
  });

  final String name;
  final int page;
  final int limit;
  final dynamic status;
  final dynamic loanTypeId;
}
