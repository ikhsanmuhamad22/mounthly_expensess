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
  decimalDigits: 2, // biasanya pakai 2 digit untuk cents
);
