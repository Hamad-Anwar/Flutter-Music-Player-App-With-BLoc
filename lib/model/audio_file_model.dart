class AudioFile {
  final int? id;
  final String? name;
  final String? path;
  final int? isFavourite;
  final String? size;
  final String? length;
  AudioFile({this.id, this.name, this.path, this.size, this.length,this.isFavourite,});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'path': path,
      'size': size,
      'length': length,
      'isFavourite': isFavourite,
    };
  }
  factory AudioFile.fromMap(Map<String, dynamic> map) {
    return AudioFile(
      id: map['id'],
      name: map['name'],
      path: map['path'],
      size: map['size'],
      length: map['length'],
      isFavourite: map['isFavourite']
    );
  }
}