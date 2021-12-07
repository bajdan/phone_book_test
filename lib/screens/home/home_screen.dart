import 'package:flutter/material.dart';
import 'package:phone_book_test/repositories/contacts_repository.dart';
import 'package:phone_book_test/screens/home/cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_book_test/screens/home/cubit/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeCubit _cubit;

  @override
  void initState() {
    _cubit = HomeCubit(contactsRepo: context.read<ContactsRepo>())
      ..loadContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3f3f3f),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/user_add');
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFFdf6977),
      ),
      body: SafeArea(
        child: BlocBuilder(
          bloc: _cubit,
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HomeLoadedState) {
              return ListView.builder(
                  itemCount: state.contacts.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      child: GestureDetector(
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: ListTile(
                            tileColor: const Color(0xFF211f20),
                            title: Text(state.contacts[index].name, style: const TextStyle(color: Colors.white),),
                          ),
                        ),
                        onTap: (){
                          Navigator.pushNamed(context, '/full_info', arguments: {
                            'contact' : state.contacts[index]
                          });
                        },
                      ),
                      onDismissed: (_){
                        _cubit.deleteContacts(state.contacts[index].id);
                      },
                    );
                  });
            }
            return const Center(
              child: Text(
                'Something Wrong!',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
