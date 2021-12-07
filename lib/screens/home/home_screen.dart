import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_book_test/models/contat_model.dart';
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
      ..loadContactsFromNetwork();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3f3f3f),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/user_add');
          _cubit.loadContactsFromNetwork();
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
                          color: Colors.transparent,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            tileColor: const Color(0xFF211f20),
                            leading: SizedBox(
                              width: 70,
                              height: 70,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: CircleAvatar(
                                    radius: 25.0,
                                    backgroundImage: NetworkImage(
                                      _cubit.contacts[index].avatar,
                                    ),
                                    onBackgroundImageError:  (exception,context) {
                                      print('${_cubit.contacts[index].avatar} Cannot be loaded');
                                    },
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              state.contacts[index].name,
                              style: const TextStyle(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/full_info',
                              arguments: {'contact': state.contacts[index]});
                        },
                      ),
                      onDismissed: (_) {
                        _cubit.deleteContacts(state.contacts[index].id);
                      },
                    );
                  });
            }
            if(state is HomeLoadedFromDBState){
              return StreamBuilder<List<ContactModel>>(
                stream: state.contactStream,
                  builder:
                  (context, snapshot){
                if(snapshot.hasData){
                  if(snapshot.data!.isNotEmpty){
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                        itemBuilder: (context, index){
                      return GestureDetector(
                        child: Card(
                          color: Colors.transparent,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            tileColor: const Color(0xFF211f20),
                            leading:  SizedBox(
                              width: 70,
                              height: 70,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CircleAvatar(
                                  radius: 25.0,
                                  child: Image.asset(
                                      'assets/images/error_loading_image.png',
                                    fit: BoxFit.contain,
                                  ),
                                  backgroundColor: Colors.black,
                                ),
                              ),
                            ),
                            title: Text(
                              snapshot.data![index].name,
                              style: const TextStyle(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/full_info',
                              arguments: {'contact': snapshot.data![index]});
                        },
                      );
                    });
                  }
                  else{
                    return const Center(child: Text('Ууупс, тут пусто...', style: TextStyle(color: Colors.white),),);
                  }
                }else{
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              });
            }
            if (state is HomeErrorState) {
              return const Center(
                child: Text('ERROR!', style: TextStyle(color: Colors.white)),
              );
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
