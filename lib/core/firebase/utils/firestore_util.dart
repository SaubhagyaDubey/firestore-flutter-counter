
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_counter/core/firebase/model/counter_page_model.dart';

class FirestoreUtil{
  static const String pagesCollection = 'pages';
  
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference pages = FirebaseFirestore.instance.collection(pagesCollection);


  Future<void> deletePage() async{
    await pages.get().then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
  }

  Future<void> addPages(CounterPageModel model) async {
    await pages.doc(model.pageIndex).set(model.toJson());
  }

  Future<CounterPageModel?> getPages(String page) async{
    CounterPageModel? pageModel;
    DocumentSnapshot snapshot = await pages.doc(page).get();

    if(snapshot.exists){
      pageModel = CounterPageModel.fromJson(snapshot.data() as Map<String,dynamic>);
    }
    return pageModel;
  }

}