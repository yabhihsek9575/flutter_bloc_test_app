import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user_bloc.dart';
import '../screens/user_detail_screen.dart';

class UserCard extends StatelessWidget {
  final User user;
    final void Function(User user)? onAdd;


  UserCard({required this.user, this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(user.name ?? 'Name'),
        subtitle: Text(user.email ?? 'someeone@example.com'),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            context.read<UserBloc>().add(DeleteUser(user.id ?? 0));
          },
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => UserDetailScreen(user: user, onUpdate: onAdd,),
            ),
          );
        },
      ),
    );
  }
}
