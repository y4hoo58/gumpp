class AppParams {
  /*
    Uygulama başlatıldığı zaman tflite modelinin hafızadaki yeri bu değişkene atanır.
   */
  static int interpreterAddress;

  /*
    Hangi kameranın kullanılacağını tutar.
    Bir çok class'ın bu parametereye erişimi var.
  */
  static bool isFrontCam;

  /*
    Ekran boyutlarını tutar. 
    [width,height]
    HomeScreen State'i her build attığı zaman bu değer güncellenir.
    Başka bir bu değişkene erişim yok.
  */
  static List<double> gameSize;

  /* 
    gameState:
    -999 : garbage data
    -4 : finishgame fonksiyonu çalıştırıldı
    -3 : menüye dönüldü
    -2 : retry atıldı
    -1 : bekleme ekranında bekleniyor
     0 : oyun oynanıyor
     1 : player öldü
     2 : kamera bekleniyor
     3 : pause screen
  */
  static int gameState = -999;

  /*
    Bu değere null atanamasa da default olarak 0 başlatmak daha iyi olur.
  */
  static int bestScore = 0;

  /*
    Anlık score'u tutar.
    Bu değer bestScore'u aşarsa kaydedilir.
  */
  static int totalScore = 0;

  /* 
    Tutorial ekranının gösterilip gösterilmemesi bu bool değere bağlıdır.
    isTutorial değişkeni tutorial süresi bittiği zaman otomatik olarak
    false olarak değiştirilir ve tutorial modundan çıkış yapılmış olur.
  */
  static bool isTutorial = false;

  /* 
    Training ekranına geçilip geçilmediğini tutar.
    isTutorial'dan farkı, isTutorial oyun ilk açıldığı zaman default olarak true
    yapılır. isTraining ise kullanıcı kararına bağlı olarak true olabilir.
    isTutorial değişkeni tutorial süresi bittiği zaman otomatik olarak false'a döner 
    ve tutorial modu devre dışı kalır. Ancak isTraining asla otomatik olarak false'a dönemez.
    Bu değişkenin isTutorial'dan farkı bundan ibarettir.
  */
  static bool isTraining = false;

  /* 
    Flashın açık olup olmadığını tutar.
  */
  static bool isFlashOn = false;

  /* 
    Kullanıcının voicePref ayarını tutar.
    Oyun başlarken bu değer kayıtlardan okunur ve değiştirilir.
    Yine de default olarka true kalması daha iyi.
  */
  static bool voicePref = true;

  /*
    flashMode:
     -1 : off
     0  : auto
     1  : on
  */
  static int flashMode = 1;
}
