class ObjectTypes {
  static const String car = 'car';
  static const String loco = 'loco';
  static const String client = 'client';
  static const String bank = 'bank';
  static const String emp = 'emp';
  static const String expenses = 'expenses';
  // static const String user = 'user';
  // static const String person = 'person';

  static List<ObjecTypeItem> list = [
    ObjecTypeItem('بنك/خزنة', "bank"),
    ObjecTypeItem('سيارة', "car"),
    ObjecTypeItem('مقطورة', "loco"),
    ObjecTypeItem('عميل', "client"),
    ObjecTypeItem('موظف', "emp"),
    ObjecTypeItem('مصروفات', "expenses"),
  ];
}

class ObjecTypeItem {
  final String child;
  final String value;

  ObjecTypeItem(this.child, this.value);
}
