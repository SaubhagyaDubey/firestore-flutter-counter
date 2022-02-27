import 'package:firestore_counter/core/firebase/model/counter_page_model.dart';
import 'package:firestore_counter/core/firebase/utils/firestore_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';

part 'state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc(CounterState initialState) : super(initialState);
  FirestoreUtil firestore = FirestoreUtil();



  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if(event is SetCounterData){
      try{
      await firestore.addPages(event.pageModel);
      add(GetCounterData(pageIndex: event.pageModel.pageIndex));
      } on Exception {
        yield CounterStateError('Error on adding data. Please Retry!');
      }
    }
    else if(event is DeleteCounterData){
      try{
        await firestore.deletePage();
        add(GetCounterData(pageIndex: event.pageIndex));
      } on Exception {
        yield CounterStateError('Error on adding data. Please Retry!');
      }
    }
    else if (event is GetCounterData) {
      yield CounterStateLoading();
      try {
        var response = await firestore.getPages(event.pageIndex);
        if (response != null) {
          yield CounterStateCompleted(data: response);
        } else {
          response = CounterPageModel(counter: '0', pageIndex: event.pageIndex);
          await firestore.addPages(response);
          yield CounterStateCompleted(data: response);
        }
      } on Exception {
        yield CounterStateError('Something Went Wrong!');
      }
    }
  }
}
