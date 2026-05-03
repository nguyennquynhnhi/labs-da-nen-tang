import 'story.dart';

class StoryBrain {
  int _storyNumber = 0;
  int getStoryIndex() => _storyNumber;

  final List<Story> _stories = [
    Story(
      'Bạn đang đi bộ trong rừng thì phát hiện một chiếc rương cũ. Bạn sẽ làm gì?',
      'Mở rương ra xem',
      'Bỏ đi, không quan tâm',
    ),
    Story(
      'Bên trong rương có một bản đồ kho báu và một con dao cũ. Bạn chọn gì?',
      'Lấy bản đồ kho báu',
      'Lấy con dao để tự vệ',
    ),
    Story(
      'Bản đồ dẫn bạn đến một hang động tối tăm. Bạn nghe thấy tiếng động bên trong. Bạn sẽ?',
      'Dũng cảm bước vào',
      'Quay đầu bỏ chạy',
    ),
    Story(
      'Bên trong hang là kho vàng khổng lồ! Bạn tìm thấy kho báu và trở thành người giàu có. Chúc mừng! 🎉',
      '',
      '',
    ),
    Story(
      'Con dao giúp bạn chặt cây làm bè vượt sông. Bạn đến được một ngôi làng bình yên và sống hạnh phúc. 🏡',
      '',
      '',
    ),
    Story(
      'Trong hang là một con gấu đang ngủ! Bạn hoảng sợ bỏ chạy thoát thân. May mắn sống sót! 😅',
      '',
      '',
    ),
    Story(
      'Bạn bỏ lỡ cơ hội tìm kho báu. Cuộc sống vẫn bình thường trôi qua... Đôi khi bạn tự hỏi điều gì ở trong chiếc rương đó. 🤔',
      '',
      '',
    ),
  ];

  String getStory() => _stories[_storyNumber].storyTitle;
  String getChoice1() => _stories[_storyNumber].choice1;
  String getChoice2() => _stories[_storyNumber].choice2;

  bool isFinished() => _stories[_storyNumber].choice1 == '';

  void makeChoice(int choice) {
    if (_storyNumber == 0) {
      _storyNumber = choice == 1 ? 1 : 6;
    } else if (_storyNumber == 1) {
      _storyNumber = choice == 1 ? 2 : 4;
    } else if (_storyNumber == 2) {
      _storyNumber = choice == 1 ? 3 : 5;
    }
  }

  void reset() => _storyNumber = 0;
}