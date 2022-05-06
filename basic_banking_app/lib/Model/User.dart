final String tableUsers = 'users';

class UserFields {
  static final List<String> values = [id, name, email, cur_balance];
  static final String id = '_id';
  static final String name = 'name';
  static final String email = 'email';
  static final String cur_balance = 'cur_balance';
}

class User {
  final int? id;
  final String name;
  final String email;
  final double cur_balance;

  const User(
      {this.id,
      required this.name,
      required this.email,
      required this.cur_balance});

  User copy({
    int? id,
    String ?name,
    String ?email,
    double ?cur_balance
  }) =>
      User(
        id: id ?? this.id,
        name: name??this.name,
        email: email ?? this.email,
        cur_balance: cur_balance ?? this.cur_balance,
      );

  static User fromJson(Map<String, Object?> json) => User(
      id: json[UserFields.id] as int?,
      name: json[UserFields.name] as String,
      email: json[UserFields.email] as String,
      cur_balance: json[UserFields.cur_balance] as double);

  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.email: email,
        UserFields.cur_balance: cur_balance.toString()
      };
}
