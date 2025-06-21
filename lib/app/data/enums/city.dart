enum City {
  lienchiang,
  kinmen,
  yilan,
  hsinchuCounty,
  miaoli,
  changhua,
  nantou,
  yunlin,
  chiayiCounty,
  pingtung,
  taitung,
  hualien,
  penghu,
  keelung,
  hsinchuCity,
  chiayiCity,
  taipei,
  kaohsiung,
  newTaipei,
  taichung,
  tainan,
  taoyuan,
}

extension CityExtension on City {
  String get chineseName {
    switch (this) {
      case City.lienchiang:
        return '連江縣';
      case City.kinmen:
        return '金門縣';
      case City.yilan:
        return '宜蘭縣';
      case City.hsinchuCounty:
        return '新竹縣';
      case City.miaoli:
        return '苗栗縣';
      case City.changhua:
        return '彰化縣';
      case City.nantou:
        return '南投縣';
      case City.yunlin:
        return '雲林縣';
      case City.chiayiCounty:
        return '嘉義縣';
      case City.pingtung:
        return '屏東縣';
      case City.taitung:
        return '臺東縣';
      case City.hualien:
        return '花蓮縣';
      case City.penghu:
        return '澎湖縣';
      case City.keelung:
        return '基隆市';
      case City.hsinchuCity:
        return '新竹市';
      case City.chiayiCity:
        return '嘉義市';
      case City.taipei:
        return '臺北市';
      case City.kaohsiung:
        return '高雄市';
      case City.newTaipei:
        return '新北市';
      case City.taichung:
        return '臺中市';
      case City.tainan:
        return '臺南市';
      case City.taoyuan:
        return '桃園市';
    }
  }

  static City? fromChinese(String name) {
    if (City.values.any((c) => c.chineseName == name)) {
      return City.values.firstWhere((c) => c.chineseName == name);
    }
    return null;
  }
}
