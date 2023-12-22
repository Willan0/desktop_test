import 'package:json_annotation/json_annotation.dart';
part 'gold_price.g.dart';

@JsonSerializable()
class GoldPrice{
  @JsonKey(name: 'stateName')
  String? stateName;
  @JsonKey(name: 'stateId')
  String? stateId;

  @JsonKey(name: 'date')
  String? date;

  @JsonKey(name: 'goldPrice1')
  num? goldPrice;

  @JsonKey(name: 'currentUse')
  bool? currentUse;

  GoldPrice({
      this.stateName, this.stateId, this.date, this.goldPrice, this.currentUse});

  @override
  String toString() {
    return 'GoldPrice{stateName: $stateName, stateId: $stateId, date: $date, goldPrice: $goldPrice, currentUse: $currentUse}';
  }

  factory GoldPrice.fromJson(Map<String,dynamic> json)=> _$GoldPriceFromJson(json);
}