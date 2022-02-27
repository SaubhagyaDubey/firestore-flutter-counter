part of 'bloc.dart';

abstract class CounterEvent{}

class GetCounterData extends CounterEvent{
 String pageIndex;
 GetCounterData({required this.pageIndex});
}
class SetCounterData extends CounterEvent{
 CounterPageModel pageModel;
 SetCounterData({required this.pageModel});
}
class DeleteCounterData extends CounterEvent{
 String pageIndex;
 DeleteCounterData({required this.pageIndex});
}
