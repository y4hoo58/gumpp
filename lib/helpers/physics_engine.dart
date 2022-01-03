// ignore_for_file: non_constant_identifier_names
import 'dart:math';
import 'package:gumpp/components/sticks/sticks.dart';

class PhysicsEngine {
  PhysicsEngine() {}

  List detect_stick_collison(List<double> char_params, List<Stick> all_sticks) {
    //TODO: pong oyununda burada bug ortaya çıktı, bu oyunda da bug var mı kontrol et.
    int col_index;
    double y_correction;

    //Karaktere ait fiziksel parametreler
    double old_y_speed = char_params[0];

    double old_center_x = char_params[1];
    double old_center_y = char_params[2];

    double center_x = char_params[3];
    double center_y = char_params[4];

    double radius = char_params[5];
    double y_speed = char_params[6];

    double x2_orta = center_x;
    double y2_orta = center_y + radius;

    double x_fark = radius * sin(0.25 * 2);
    //TODO: y_speed mi yoksa old_y_speed mi ona karar verilecek..
    if (y_speed < 0) {
      // y ekseninde en yakın olan stick'i bulur.
      // Daha sonra kullanılmak üzere onun endeksini belirler.
      // En yakın stick mesafesiyle herhangi bir işimiz yok.
      double closest_distance;
      for (var i = 0; i < all_sticks.length; i++) {
        //Mesafe ölçümü stick üst çizgisine göre yapılacak.
        double stick_y_upper_line =
            all_sticks[i].center_y - (all_sticks[i].height / 2);

        //Dikey olarak en yakın stick'in endeksini buluyor.
        if (old_center_y < stick_y_upper_line) {
          double y_distance = stick_y_upper_line - old_center_y;
          if (closest_distance == null) {
            closest_distance = y_distance;
            col_index = i;
          } else if (y_distance <= closest_distance) {
            closest_distance = y_distance;
            col_index = i;
          }
        }

        //Eğer karakter dikey eksende hiç bir yatay hareket yapmadan
        //düşüyorsa eğimi sonsuza gidiyor. Zaten düz bir şekilde düşüyorsa
        //diğer hesaplamaları yapmaya gerek yok.
        double xc_orta;
        double m, b_orta;
        if (center_x == old_center_x) {
          //TODO: Bug var. Ancak buradan kaynaklı olmayabilir
          xc_orta = center_x;
        } else {
          //Karakter eğimli bir şekilde düşüyorsa eğimini bul.
          // y=mx+b
          m = ((center_y) - (old_center_y)) / (center_x - old_center_x);
          //En alt orta noktanın b değeri.
          b_orta = ((y2_orta) - (m * (x2_orta)));
        }
        if (col_index != null) {
          //En yakın stick'in üst çizgisi ve x kenarları.
          double y_upper_line = all_sticks[col_index].center_y -
              (all_sticks[col_index].height / 2);
          double x3_is_colliding = all_sticks[col_index].center_x -
              (all_sticks[col_index].width / 2);
          double x4_is_colliding = all_sticks[col_index].center_x +
              (all_sticks[col_index].width / 2);

          if (xc_orta == null) {
            xc_orta = (y_upper_line - b_orta) / (m);
          }

          //En alt noktadan sekip sekmediğini kontrol et.
          if (xc_orta >= (x3_is_colliding - x_fark) &&
              xc_orta <= (x4_is_colliding + x_fark) &&
              ((xc_orta >= old_center_x && xc_orta <= center_x) ||
                  (xc_orta <= old_center_x && xc_orta >= center_x)) &&
              ((y2_orta) >= y_upper_line)) {
            //Not: y2_orta >= y_upper_line koymayınca dik indiği zaman bug olup devamlı loop'a sarıyor
            //TODO: Burada normalde *2 yapmamız lazım sekmesi için
            //ancak sekmek yerine bir frame'i temasta göstermek daha sağlıklı
            y_correction = (y_upper_line - (y2_orta));
          }
        }
      }
    }
    return [y_correction, col_index];
  }
}
