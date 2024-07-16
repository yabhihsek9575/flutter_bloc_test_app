import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user_bloc.dart';
import '../widgets/user_card.dart';
import 'user_detail_screen.dart';


class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});


  @override
  Widget build(BuildContext context) {
     context.read<UserBloc>().add(LoadUsers());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return UserCard(user: user, onAdd: (user) {
                  context.read<UserBloc>().add(UpdateUser(user)); 
                },);
              },
            );
          } else if (state is UserError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => UserDetailScreen(onUpdate: (usr){
               context.read<UserBloc>().add(AddUser(usr));
            },)),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
//  if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     final user = User(
//                       id: widget.user?.id,
//                       name: _name,
//                       username: _username,
//                       email: _email,
//                       phone: _phone,
//                     );
//                     if (widget.user == null) {
//                       context.read<UserBloc>().add(AddUser(user));
//                     } else {
//                       context.read<UserBloc>().add(UpdateUser(user));
//                     }
//                     Navigator.of(context).pop();
//                   }
