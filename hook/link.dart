import 'package:assets/src/hook/assets_link.dart';
import 'package:native_assets_cli/data_assets.dart';

void main(List<String> arguments) {
  link(arguments, (input, output) async {
    await AssetLinker().run(input: input, output: output);
  });
}
