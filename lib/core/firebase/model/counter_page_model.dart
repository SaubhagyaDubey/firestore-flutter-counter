class CounterPageModel {
  final String pageIndex;
  final String counter;

  CounterPageModel({required this.counter, required this.pageIndex});
  CounterPageModel.fromJson(Map<String, Object?> json)
      : this(
    counter: json['counter']! as String,
    pageIndex: json['pageIndex']! as String,
  );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data.addAll({
      'pageIndex': pageIndex,
      'counter': counter,
    });
    return data;
  }
}
