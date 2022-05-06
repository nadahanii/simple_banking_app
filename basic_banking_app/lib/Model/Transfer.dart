final String tableTransfers = 'transfers';

class TransferFields {
  static final List<String> values = [
    id,
    senderName,
    receiverName,
    transferredAmount
  ];

  static final String id = '_id';
  static final String senderName = 'senderName';
  static final String receiverName = 'receiverName';
  static final String transferredAmount = 'transferredAmount';
}

class Transfer {
  final int? id;
  final String senderName;
  final String receiverName;
  final double transferredAmount;

  const Transfer(
      {this.id,
      required this.senderName,
      required this.receiverName,
      required this.transferredAmount});

  static Transfer fromJson(Map<String, Object?> json) => Transfer(
      id: json[TransferFields.id] as int?,
      senderName: json[TransferFields.senderName] as String,
      receiverName: json[TransferFields.receiverName] as String,
      transferredAmount: json[TransferFields.transferredAmount] as double);

  Map<String, Object?> toJson() => {
        TransferFields.id: id,
        TransferFields.senderName: senderName,
        TransferFields.receiverName: receiverName,
        TransferFields.transferredAmount: transferredAmount.toString()
      };
}
