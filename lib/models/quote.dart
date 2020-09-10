class QuotesResp {
  int statusCode;
  String message;
  int totalPages;
  String currentPage;
  List<Quotes> quotes;

  QuotesResp(
      {this.statusCode,
        this.message,
        this.totalPages,
        this.currentPage,
        this.quotes});

  QuotesResp.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
    if (json['quotes'] != null) {
      quotes = new List<Quotes>();
      json['quotes'].forEach((v) {
        quotes.add(new Quotes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['totalPages'] = this.totalPages;
    data['currentPage'] = this.currentPage;
    if (this.quotes != null) {
      data['quotes'] = this.quotes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Quotes {
  String sId;
  String quoteText;
  String quoteAuthor;

  Quotes({this.sId, this.quoteText, this.quoteAuthor});

  Quotes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    quoteText = json['quoteText'];
    quoteAuthor = json['quoteAuthor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['quoteText'] = this.quoteText;
    data['quoteAuthor'] = this.quoteAuthor;
    return data;
  }
}