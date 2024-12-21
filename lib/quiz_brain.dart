import 'question.dart';

class QuizBrain {

  int _questionNumber = 0;
  int _level = 1;
  List<Question> _questionBank = [];
  List<Question> _level1Questions = [
    Question(questionText: 'Some cats are actually allergic to humans', questionAnswer: true),
    Question(questionText: 'You can lead a cow down stairs but not up stairs.', questionAnswer: false),
    Question(questionText: 'Approximately one quarter of human bones are in the feet.', questionAnswer: true),
    Question(questionText: 'A slug\'s blood is green.', questionAnswer: true),
    Question(questionText: 'Buzz Aldrin\'s mother\'s maiden name was "Moon".', questionAnswer: true),
    Question(questionText: 'It is illegal to pee in the Ocean in Portugal.', questionAnswer: true),
    Question(questionText: 'No piece of square dry paper can be folded in half more than 7 times.', questionAnswer: false),
    Question(questionText: 'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.', questionAnswer: true),
    Question(questionText: 'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.', questionAnswer: false),
    Question(questionText: 'The total surface area of two human lungs is approximately 70 square metres.', questionAnswer: true),
    Question(questionText: 'Google was originally called "Backrub".', questionAnswer: true),
    Question(questionText: 'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.', questionAnswer: true),
    Question(questionText: 'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.', questionAnswer: true),
  ];

  List<Question> _level2Questions = [
    Question(questionText: 'Bananas are berries but strawberries are not.', questionAnswer: true),
    Question(questionText: 'Lightning never strikes the same place twice.', questionAnswer: false),
    Question(questionText: 'A rhinoceros\' horn is made of hair.', questionAnswer: true),
    Question(questionText: 'There are more stars in the universe than grains of sand on all the world\'s beaches.', questionAnswer: true),
    Question(questionText: 'Humans and giraffes have the same number of neck vertebrae.', questionAnswer: true),
  ];

  List<Question> _level3Questions = [
    Question(questionText: 'Honey never spoils.', questionAnswer: true),
    Question(questionText: 'The Great Wall of China is visible from space.', questionAnswer: false),
    Question(questionText: 'Octopuses have three hearts.', questionAnswer: true),
    Question(questionText: 'Goldfish only have a three-second memory.', questionAnswer: false),
    Question(questionText: 'Humans can distinguish over a million different colors.', questionAnswer: true),
  ];

  List<Question> _level4Questions = [
    Question(questionText: 'An octopus has eight hearts.', questionAnswer: false),
    Question(questionText: 'The Eiffel Tower can be 15 cm taller during the summer.', questionAnswer: true),
    Question(questionText: 'Humans and dolphins are the only animals that have sex for pleasure.', questionAnswer: false),
    Question(questionText: 'A day on Venus is longer than a year on Venus.', questionAnswer: true),
    Question(questionText: 'There are more fake flamingos in the world than real flamingos.', questionAnswer: true),
  ];

  List<Question> _level5Questions = [
    Question(questionText: 'Slugs have four noses.', questionAnswer: true),
    Question(questionText: 'The unicorn is the national animal of Scotland.', questionAnswer: true),
    Question(questionText: 'A group of flamingos is called a "flamboyance".', questionAnswer: true),
    Question(questionText: 'There are more atoms in a glass of water than glasses of water in all the oceans on Earth.', questionAnswer: true),
    Question(questionText: 'A snail can sleep for three years.', questionAnswer: true),
  ];

  QuizBrain() {
    _questionBank = _level1Questions;
  }

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    } else {
      print('Level $_level completed! Please proceed to the next level.');
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  int getTotalQuestions() {
    return _questionBank.length;
  }

  void reset() {
    _questionNumber = 0;
  }

  int get questionNumber {
    return _questionNumber;
  }

  int get level {
    return _level;
  }

  void nextLevel() {
    _level++;
    _questionNumber = 0;
    switch (_level) {
      case 2:
        _questionBank = _level2Questions;
        break;
      case 3:
        _questionBank = _level3Questions;
        break;
      case 4:
        _questionBank = _level4Questions;
        break;
      case 5:
        _questionBank = _level5Questions;
        break;
      default:
        _level = 1;
        _questionBank = _level1Questions;
        break;
    }
  }

  void restartQuiz() {
    _level = 1;
    _questionBank = _level1Questions;
    reset();
  }
}
