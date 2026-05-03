import 'dart:math';

class CalculatorBrain {
  final int height;
  final int weight;

  CalculatorBrain(this.height, this.weight);

  double _bmi = 0;

  String calculateBMI() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi >= 30) return 'Béo phì';
    if (_bmi >= 25) return 'Thừa cân';
    if (_bmi >= 18.5) return 'Bình thường';
    return 'Thiếu cân';
  }

  String getInterpretation() {
    if (_bmi >= 30) {
      return 'Chỉ số BMI của bạn ở mức béo phì. Hãy tham khảo ý kiến bác sĩ để có kế hoạch giảm cân an toàn và hiệu quả.';
    }
    if (_bmi >= 25) {
      return 'Bạn đang thừa cân. Hãy tăng cường vận động và điều chỉnh chế độ ăn uống lành mạnh hơn.';
    }
    if (_bmi >= 18.5) {
      return 'Bạn có cân nặng bình thường. Hãy duy trì lối sống lành mạnh và tập thể dục đều đặn!';
    }
    return 'Bạn đang thiếu cân. Hãy ăn uống đầy đủ dinh dưỡng và tham khảo ý kiến bác sĩ nếu cần.';
  }
}