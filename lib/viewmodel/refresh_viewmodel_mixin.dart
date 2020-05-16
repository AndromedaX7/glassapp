abstract class RefreshViewModelMixin {
  bool canLoad = false;
  int page = 1;

  nextPage() {
    page++;
    return this;
  }

  cleanPage() {
    dataClear();
    page = 1;
    return this;
  }

  dataClear();
}
