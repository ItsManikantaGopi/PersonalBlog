// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/repositories/portfolio_repository.dart' as _i157;
import '../../features/art/art_repository.dart' as _i987;
import '../../services/github_service.dart' as _i72;
import 'injection.dart' as _i464;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i987.ArtRepository>(() => _i987.ArtRepository());
    gh.singleton<_i361.Dio>(() => registerModule.dio);
    gh.factory<_i72.GitHubService>(() => _i72.GitHubService(gh<_i361.Dio>()));
    gh.factory<_i157.PortfolioRepository>(
        () => _i157.PortfolioRepository(gh<_i72.GitHubService>()));
    return this;
  }
}

class _$RegisterModule extends _i464.RegisterModule {}
