import '../data/vms/sale_voucher/total_value_vm.dart';

class UnitConverter{

  static num changeGoldWeightToGram(num kyat,num pae,num yawe){
    if(kyat <=0 && pae<=0 && yawe <=0 ){
      return 0;
    }
    num p = pae==0? 0:pae/16;
    num y = yawe==0? 0:yawe/128;
    return (kyat + p + y) * 16.6;
  }

  static num calculateTheTotalAmtForKPY( num kyat,num pae,num yawe,num goldPrice){
    num p = pae==0? 0:pae/16;
    num y = yawe==0? 0:yawe/128;
    return (kyat+p+y) * goldPrice;
  }

  static List<num> calculateTotalToKPY(num totalAmt, num goldPrice) {
    List<num> kpyList = [];
    num kyat = 0;
    num pae = 0;
    num yawe = 0;
    num temp1 = totalAmt / goldPrice;
    num temp2 = 0;

    kyat = temp1;
    temp2 = kyat - temp1.floor();

    kpyList.add(kyat.floor());
    temp1 = temp2 * 16;
    pae = temp1;
    kpyList.add(pae.floor());

    temp2 = temp1 - pae.floor();
    yawe = temp2 * 8;
    kpyList.add(yawe);

    return kpyList;
  }

  static List<num> changeGramToGoldWeight(num gram) {
    //****   1 Gram => 0.060241 Kyat

    List<num> result = [];
    num kyat = 0;
    num pae = 0;
    num yawe = 0;

    num temp1 = gram * 0.060241;
    num temp2 = 0;

    if (temp1 > 1) {
      kyat = temp1;
      temp2 = temp1 - kyat.floor();
    } else {
      kyat = 0;
      temp2 = temp1;
    }

    result.add(kyat.floor());

    temp1 = temp2 * 16;

    if (temp1 > 1) {
      pae = temp1;
      temp2 = temp1 - pae.floor();
    } else {
      pae = 0;
      temp2 = temp1;
    }

    result.add(pae.floor());


    if (temp2 > 0) {
      yawe = temp2 * 8;
    } else {
      yawe = 0;
    }

    result.add(yawe);
    return result;
  }

  static List<num> changeGoldState(num kyat ,num pae ,num yawe,String stateId){
    num gram = changeGoldWeightToGram(kyat, pae, yawe);
    num changedGram = 0;
    goldStates.forEach((key, value) {
      if(key.trim().toLowerCase()==stateId.trim().toLowerCase()){
        changedGram = (gram/value) * 16;
      }
    });
    return changeGramToGoldWeight(changedGram);
  }

  static TotalValueVM adjustGoldWeight(TotalValueVM totalValue,num adjustValue,bool isIncrease ,num goldPrice){
    num maximumVal = totalValue.tGram16! +adjustValue;
    num minimumVal = totalValue.tGram16! -adjustValue;
    if(isIncrease){
      if(totalValue.tAdjustableGram! < maximumVal){
        final adjustGram = totalValue.tAdjustableGram! + 0.01;
        List<num> adjusted16KPY = UnitConverter.changeGramToGoldWeight(adjustGram);
        totalValue.tAdjustableGram = adjustGram;
        totalValue.tAdjustableKyat = adjusted16KPY[0];
        totalValue.tAdjustablePae = adjusted16KPY[1];
        totalValue.tAdjustableYawe = adjusted16KPY[2];
        totalValue.totalAmt = (adjusted16KPY[0] + (adjusted16KPY[1] /16) + (adjusted16KPY[2]/ 128)) * goldPrice;
       return totalValue;
      }
    }else{
      if(totalValue.tAdjustableGram! > minimumVal){
        final adjustGram = totalValue.tAdjustableGram! - 0.01;
        List<num> adjusted16KPY = UnitConverter.changeGramToGoldWeight(adjustGram);
        totalValue.tAdjustableGram = adjustGram;
        totalValue.tAdjustableKyat = adjusted16KPY[0];
        totalValue.tAdjustablePae = adjusted16KPY[1];
        totalValue.tAdjustableYawe = adjusted16KPY[2];
        totalValue.totalAmt = (adjusted16KPY[0] + (adjusted16KPY[1] /16) + (adjusted16KPY[2]/ 128)) * goldPrice;
        return totalValue;
      }
    }
    return totalValue;
  }

  static Map<String,dynamic> goldStates = {
    "AC":16,
    "A0":16,
    "B0":17,
    "C0":18,
    "C1":17.5,
    "D0":19,
    "E0":20,
    "E1":19.5,
    "E2":20,
    "E3":20,
    "ET ":20,
    "F0":21,
    "F1":20.5,
    "G0":22,
    "G1":21.5,
    "H0":23,
    "H1":22.5,
    "I0":24,
    "I1":23.5,
    "JO":0,
    "P4":22.5,
    "P8":20
  };
}