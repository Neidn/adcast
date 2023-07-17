// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankData _$BankDataFromJson(Map<String, dynamic> json) => BankData(
      bankName: json['bank_name'] as String?,
      bankNum: json['bank_num'] as String?,
      bankOwner: json['bank_owner'] as String?,
    );

Map<String, dynamic> _$BankDataToJson(BankData instance) => <String, dynamic>{
      'bank_name': instance.bankName,
      'bank_num': instance.bankNum,
      'bank_owner': instance.bankOwner,
    };
