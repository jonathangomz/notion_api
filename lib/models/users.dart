import 'package:notion_api/models/objects.dart';

enum UserType {
  person,
  bot,
}

class User {
  NotionObjects object = NotionObjects.user;
  String? id;
  UserType? type;
  String? name;
  String? avatar_url;
}

class _People {
  String? email;
}

class PeopleUser extends User {
  _People? people;
}

class BotUser extends User {}
