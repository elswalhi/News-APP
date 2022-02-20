abstract class Newsstates{}

class NewsInitialState extends Newsstates{}

class NewsBottonNavState extends Newsstates{}

class newsGetBuisnessSuccess extends Newsstates{}

class newsGetBuisnessLoding extends Newsstates{}


class newsGetBuisnessError extends Newsstates{
  late final String? error;
  newsGetBuisnessError(this.error);
}

class newsGetSportsSuccess extends Newsstates{}

class newsGetSportsLoding extends Newsstates{}


class newsGetSportsError extends Newsstates{
   late final String? error;
   newsGetSportsError(
       this.error
       );
}

class newsGetSciencesSuccess extends Newsstates{}

class newsGetSciencesLoding extends Newsstates{}

class ChangeAppMode extends Newsstates{}

class newsGetSciencesError extends Newsstates{
  late final String? error;
  newsGetSciencesError(
      this.error
      );
}
class newsGetSearchSuccess extends Newsstates{}

class newsGetSearchLoding extends Newsstates{}

class newsGetSearchError extends Newsstates{
  late final String? error;
  newsGetSearchError(
      this.error
      );
}
