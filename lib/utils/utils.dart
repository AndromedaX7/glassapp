bool canLoad(int page, int size, int count) {
  return page * size < count;
}

int isTaobao(bool taobao) {
  return taobao ? 1 : 0;
}

isTaobao2(bool taobao) {
  return taobao ? 1 : "";
}