import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_book_test/models/contact_model.dart';
import 'package:phone_book_test/repositories/contacts_repository.dart';
import 'package:phone_book_test/screens/home/cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_book_test/screens/home/cubit/home_state.dart';
import 'package:phone_book_test/screens/home/widgets/custom_db_card.dart';
import 'package:phone_book_test/screens/home/widgets/custom_network_card.dart';

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
      appBar: AppBar(
        title: const Text('ALL CONTACTS'),
        centerTitle: true,
        backgroundColor: const Color(0xFF211f20),
      ),
      backgroundColor: const Color(0xFF3f3f3f),
      floatingActionButton: BlocBuilder(
        bloc: _cubit,
        builder: (context, state) {
          if (state is HomeLoadedState) {
            return FloatingActionButton(
              onPressed: () async {
                await Navigator.pushNamed(context, '/user_add');
                _cubit.loadContactsFromNetwork();
              },
              child: const Icon(Icons.add),
              backgroundColor: const Color(0xFFdf6977),
            );
          }
          return Container();
        },
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
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 15.0),
                      child: Dismissible(
                        key: Key(state.contacts[index].id.toString()),
                        child: CustomNetworkCad(contact: state.contacts[index]),
                        onDismissed: (_) {
                          _cubit.deleteContact(state.contacts[index].id);
                          setState(() {
                            state.contacts.removeAt(index);
                          });
                        },
                      ),
                    );
                  });
            }
            if (state is HomeLoadedFromDBState) {
              return StreamBuilder<List<ContactModel>>(
                  stream: state.contactStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return CustomDBCard(
                                contact: snapshot.data![index],
                              );
                            });
                      } else {
                        return const Center(
                          child: Text(
                            'Wooops, its empty...',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  });
            }
            if (state is HomeErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'ERROR!',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        _cubit.loadContactsFromNetwork();
                      },
                      icon: const Icon(
                        Icons.cached,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
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
