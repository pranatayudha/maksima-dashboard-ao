bool isImageOrPdf(String type) {
  return (type.toLowerCase() == 'pdf' ||
      type.toLowerCase() == 'jpg' ||
      type.toLowerCase() == 'png' ||
      type.toLowerCase() == 'jpeg');
}

bool isImage(String type) {
  return (type.toLowerCase() == 'jpg' ||
      type.toLowerCase() == 'png' ||
      type.toLowerCase() == 'jpeg');
}
