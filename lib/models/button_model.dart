class ButtonModel {
  final String id;
  final String label;
  final String buttonpressedEvent;
  final String buttonReleasedEvent;

  ButtonModel({
    required this.label,
    required this.buttonpressedEvent,
    required this.buttonReleasedEvent,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'label': label,
      'buttonpressedEvent': buttonpressedEvent,
      'buttonReleasedEvent': buttonReleasedEvent,
    };
  }

  factory ButtonModel.fromMap(Map<String, dynamic> map) {
    return ButtonModel(
      id: map['id'] as String,
      label: map['label'] as String,
      buttonpressedEvent: map['buttonpressedEvent'] as String,
      buttonReleasedEvent: map['buttonReleasedEvent'] as String,
    );
  }
}
