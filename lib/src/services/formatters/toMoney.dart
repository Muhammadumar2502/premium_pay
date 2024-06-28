String toMoney(num? n) {
  
  if (n == null || n==0) {
    return "0";
  }
  
  String result = "";
  String number = n.toString().split(".")[0];
  for (int i = 0; i < number.length; i++) {
    result += number[i];
    if ((number.length - i) % 3 == 1 && i!=number.length-1) {
      result += " ";
    }
  }
  String extraV="00" ;
  if (n.toString().split(".").length > 1) {
    if (n.toString().split(".")[1].length>1) {
      extraV = n.toString().split(".")[1].substring(0,2);
    }else{
      extraV = n.toString().split(".")[1].substring(0,1)+"0";
    }

    
  }
  print("extraV"+extraV);
  return result +","+extraV;
}