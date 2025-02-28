import 'package:logging/logging.dart' show Logger;
import 'package:native_assets_cli/data_assets.dart';

import 'assets.dart';

class AssetBuilder {
  final Map<String, Uri> stringFiles;
  final Map<String, Uri> byteFiles;

  AssetBuilder({required this.stringFiles, required this.byteFiles});

  AssetBuilder.byteFile(String name, Uri file)
    : byteFiles = {name: file},
      stringFiles = {};

  AssetBuilder.stringFile(String name, Uri file)
    : byteFiles = {},
      stringFiles = {name: file};

  Future<void> run({
    required BuildInput input,
    required BuildOutputBuilder output,
    required Logger? logger,
    String? linkInPackage,
  }) async {
    output.assets.data.addAll(
      [
        ...stringFiles
            .map(
              (name, uri) => MapEntry(assetNameMangler<StringAsset>(name), uri),
            )
            .entries,
        ...byteFiles
            .map(
              (name, uri) => MapEntry(assetNameMangler<ByteAsset>(name), uri),
            )
            .entries,
      ].map(
        (file) => DataAsset(
          file: file.value,
          name: file.key,
          package: input.packageName,
        ),
      ),
    );
  }

  static String assetNameMangler<T extends Asset>(String name) => switch (T) {
    StringAsset() => '${StringAsset.uniquePrefix}/$name',
    ByteAsset() => '${ByteAsset.uniquePrefix}/$name',
    Type() => throw ArgumentError('Unknown type $T'),
  };
}
