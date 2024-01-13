class ContainerModel {
  final String label;
  final String buttonpressedEvent;
  final String buttonReleasedEvent;

  ContainerModel({
    required this.label,
    required this.buttonpressedEvent,
    required this.buttonReleasedEvent,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'label': label,
      'buttonpressedEvent': buttonpressedEvent,
      'buttonReleasedEvent': buttonReleasedEvent,
    };
  }

  factory ContainerModel.fromMap(Map<String, dynamic> map) {
    return ContainerModel(
      label: map['label'] as String,
      buttonpressedEvent: map['buttonpressedEvent'] as String,
      buttonReleasedEvent: map['buttonReleasedEvent'] as String,
    );
  }
}
