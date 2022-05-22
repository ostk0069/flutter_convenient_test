import 'package:mobx/mobx.dart';

part 'global_config_store.g.dart';

class GlobalConfigStore {
  static final config = GlobalConfig.fromEnvironment();
}

class GlobalConfig extends _GlobalConfig with _$GlobalConfig {
  GlobalConfig._({
    required bool isolationMode,
    required bool enableReportSaver,
    required String? goldenDiffGitRepo,
  }) : super._(
          isolationMode: isolationMode,
          enableReportSaver: enableReportSaver,
          goldenDiffGitRepo: goldenDiffGitRepo,
        );

  factory GlobalConfig.fromEnvironment() {
    return GlobalConfig._(
      isolationMode: const bool.fromEnvironment('CONVENIENT_TEST_ISOLATION_MODE', defaultValue: false),
      enableReportSaver: false,
      goldenDiffGitRepo: _emptyToNull(const String.fromEnvironment('CONVENIENT_TEST_GOLDEN_DIFF_GIT_REPO')),
    );
  }
}

abstract class _GlobalConfig with Store {
  @observable
  bool isolationMode;

  @observable
  bool enableReportSaver;

  @observable
  String? goldenDiffGitRepo;

  _GlobalConfig._({
    required this.isolationMode,
    required this.enableReportSaver,
    required this.goldenDiffGitRepo,
  });
}

String? _emptyToNull(String s) => s.isEmpty ? null : s;
