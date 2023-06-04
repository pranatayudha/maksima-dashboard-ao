enum StatusKelolaanType {
  jumlahPartner,
  jumlahPipeline,
  prosesAnalisa,
  prosesPutusan,
  prosesAkadDanPencairan,
}

String parseStatusKelolaanTypeToString(StatusKelolaanType statusKelolaanType) {
  switch (statusKelolaanType) {
    case StatusKelolaanType.jumlahPartner:
      return 'Jumlah Partner';

    case StatusKelolaanType.jumlahPipeline:
      return 'Jumlah Pipeline';

    case StatusKelolaanType.prosesAnalisa:
      return 'Proses Analisa';

    case StatusKelolaanType.prosesPutusan:
      return 'Proses Putusan';

    case StatusKelolaanType.prosesAkadDanPencairan:
      return 'Proses Akad & Pencairan';

    default:
      return '';
  }
}
