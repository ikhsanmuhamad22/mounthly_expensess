import 'package:intl/intl.dart';

final formatRupiah = NumberFormat.currency(
  locale: 'id_ID',
  symbol: 'Rp',
  decimalDigits: 0,
);

// Format Dollar
final formatDollar = NumberFormat.currency(
  locale: 'en_US',
  symbol: '\$',
  decimalDigits: 2,
);

final dateFormat = DateFormat('dd/MM/yyyy');
final timeFormat = DateFormat('HH:mm');
