import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;

  final List<Question> _questions = [
    Question('Trái đất quay quanh mặt trời mất 365 ngày.', true),
    Question('Việt Nam có 64 tỉnh thành.', false),
    Question('Voi là loài động vật có vú lớn nhất trên cạn.', true),
    Question('Nước sôi ở 100 độ C trong điều kiện bình thường.', true),
    Question('Mặt trăng có thể tự phát sáng.', false),
    Question('Con người sử dụng 100% não bộ mỗi ngày.', false),
    Question('Cá heo là loài động vật có vú.', true),
    Question('Việt Nam nằm ở khu vực Đông Nam Á.', true),
    Question('Kim cương là vật liệu cứng nhất trong tự nhiên.', true),
    Question('Hà Nội là thủ đô của Việt Nam.', true),
  ];

  String getQuestion() {
    return _questions[_questionNumber].questionText;
  }

  bool getAnswer() {
    return _questions[_questionNumber].questionAnswer;
  }

  void nextQuestion() {
    if (_questionNumber < _questions.length - 1) {
      _questionNumber++;
    }
  }

  bool isFinished() {
    return _questionNumber >= _questions.length - 1;
  }

  void reset() {
    _questionNumber = 0;
  }
}