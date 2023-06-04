import 'detail_agunan_tambahan_model.dart';

class ItemDataPembandingModel {
  String? id;
  String? sumberData;
  List<PathFotoAgunanTambahan>? pathFoto;
  List<PathFotoAgunanTambahan>? pathDokumenPembanding;
  String? linkInternet;
  String? noHp;
  String? hargaAsetPembanding;
  String? luasAsetPembanding;
  String? hargaTanahPerM2;

  ItemDataPembandingModel({
    this.id,
    this.sumberData,
    this.pathFoto,
    this.pathDokumenPembanding,
    this.linkInternet,
    this.noHp,
    this.hargaAsetPembanding,
    this.luasAsetPembanding,
    this.hargaTanahPerM2,
  });

  ItemDataPembandingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    sumberData = json['sumberData'] as String?;
    pathFoto = (json['pathFoto'] as List?)
        ?.map(
          (dynamic e) =>
              PathFotoAgunanTambahan.fromJson(e as Map<String, dynamic>),
        )
        .toList();
    pathDokumenPembanding = (json['pathDokumenPembanding'] as List?)
        ?.map(
          (dynamic e) =>
              PathFotoAgunanTambahan.fromJson(e as Map<String, dynamic>),
        )
        .toList();
    linkInternet = json['linkInternet'] as String?;
    noHp = json['noHp'] as String?;
    hargaAsetPembanding = json['hargaAsetPembanding'] as String?;
    luasAsetPembanding = json['luasAsetPembanding'] as String?;
    hargaTanahPerM2 = json['hargaTanahPerM2'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id ?? '';
    json['sumberData'] = sumberData;
    json['pathFoto'] = (pathFoto?.isNotEmpty ?? false)
        ? pathFoto?.map((e) => e.toJson()).toList()
        : [];
    json['pathDokumenPembanding'] = (pathDokumenPembanding?.isNotEmpty ?? false)
        ? pathDokumenPembanding?.map((e) => e.toJson()).toList()
        : [];
    json['linkInternet'] = linkInternet ?? '';
    json['noHp'] = noHp;
    json['hargaAsetPembanding'] = hargaAsetPembanding;
    json['luasAsetPembanding'] = luasAsetPembanding;
    json['hargaTanahPerM2'] = hargaTanahPerM2;

    return json;
  }
}
