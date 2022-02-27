import 'package:firestore_counter/core/bloc/fetch_counter_bloc/bloc.dart';
import 'package:firestore_counter/core/firebase/model/counter_page_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  final CounterBloc bloc = CounterBloc(CounterStateInitial());

  int _counter = 0;

  @override
  void initState() {
    bloc.add(GetCounterData(pageIndex: currentPage.toString()));
    super.initState();
  }

  List<BottomNavigationBarItem> navItems = List.generate(
    3,
    (index) => BottomNavigationBarItem(
      icon: const Icon(Icons.calculate),
      label: 'Counter $index',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App'),
        actions: [
          IconButton(
              onPressed: () {
                bloc.add(DeleteCounterData(pageIndex: currentPage.toString()));
              },
              icon: const Icon(Icons.restart_alt))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Increment me!'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () {
          _counter += 1;
          bloc.add(SetCounterData(
              pageModel: CounterPageModel(
            pageIndex: currentPage.toString(),
            counter: _counter.toString(),
          )));
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: navItems,
        currentIndex: currentPage,
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
          bloc.add(GetCounterData(pageIndex: currentPage.toString()));
        },
      ),
      body: BlocBuilder<CounterBloc, CounterState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is CounterStateCompleted) {
            _counter = int.parse(state.data.counter);
            return Center(child: Text('Counter $_counter'));
          }
          if (state is CounterStateError) {
            return Center(child: Text(state.error));
          }
          return Container();
        },
      ),
    );
  }
}
