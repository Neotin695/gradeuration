// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class CurrencyEntity extends Equatable {
  final List<CurrencyData> prices;
  const CurrencyEntity({
    required this.prices,
  });

  @override
  List<Object> get props => [prices];
}

class CurrencyData extends Equatable {
  final String country;
  final String price;
  final String prefix;
  final String currency;
  final String ar;
  const CurrencyData({
    required this.country,
    required this.price,
    required this.prefix,
    required this.currency,
    required this.ar,
  });

  @override
  List<Object> get props => [country, price, prefix, currency, ar];

  factory CurrencyData.fromMap(Map<String, dynamic> map) {
    return CurrencyData(
      country: map['country'] as String,
      price: map['price'] as String,
      prefix: map['prefix'] as String,
      ar: map['ar'],
      currency: map['currency'] as String,
    );
  }
}
