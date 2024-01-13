class ButtonModel {
  final String id;
  final String label;
  final String buttonPressedEvent;
  final String buttonReleasedEvent;

  ButtonModel({
    required this.label,
    required this.buttonPressedEvent,
    required this.buttonReleasedEvent,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'label': label,
      'buttonPressedEvent': buttonPressedEvent,
      'buttonReleasedEvent': buttonReleasedEvent,
    };
  }

  factory ButtonModel.fromMap(Map<String, dynamic> map) {
    return ButtonModel(
      id: map['id'],
      label: map['label'],
      buttonPressedEvent: map['buttonPressedEvent'],
      buttonReleasedEvent: map['buttonReleasedEvent'],
    );
  }
}
