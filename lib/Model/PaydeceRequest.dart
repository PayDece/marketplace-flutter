class PaydeceRequest {
  bool? ok;
  Data? data;
  Null? error;

  PaydeceRequest({ok, data, error});

  PaydeceRequest.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'];
  }
}

class Data {
  int? count;
  int? pageSize;
  int? currentPage;
  int? totalItems;
  int? totalPages;
  late List<Items> items;

  Data({count, pageSize, currentPage, totalItems, totalPages, items});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    pageSize = json['pageSize'];
    currentPage = json['currentPage'];
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }
}

class Items {
  late int buyOrderId;
  int? buyerId;
  Buyer? buyer;
  int? cryptoId;
  Crypto? crypto;
  int? fiatCoinId;
  FiatCoin? fiatCoin;
  String? paymentMethods;
  double? amount;
  double? fiatPrice;
  double? fromAmountRange;
  double? toAmountRange;
  String? terms;
  int? status;
  String? hash;
  String? location;
  bool? hasActiveTransactions;
  bool? isPublic;

  Items(
      {buyOrderId,
      buyerId,
      Buyer? buyer,
      cryptoId,
      crypto,
      fiatCoinId,
      fiatCoin,
      paymentMethods,
      amount,
      fiatPrice,
      fromAmountRange,
      toAmountRange,
      terms,
      status,
      hash,
      location,
      hasActiveTransactions,
      isPublic});

  Items.fromJson(Map<String, dynamic> json) {
    buyOrderId = json['buyOrderId'];
    buyerId = json['buyerId'];
    buyer = json['buyer'] != null ? new Buyer.fromJson(json['buyer']) : null;
    cryptoId = json['cryptoId'];
    crypto =
        json['crypto'] != null ? new Crypto.fromJson(json['crypto']) : null;
    fiatCoinId = json['fiatCoinId'];
    fiatCoin = json['fiatCoin'] != null
        ? new FiatCoin.fromJson(json['fiatCoin'])
        : null;
    paymentMethods = json['paymentMethods'];
    amount = json['amount'];
    fiatPrice = json['fiatPrice'];
    fromAmountRange = json['fromAmountRange'];
    toAmountRange = json['toAmountRange'];
    terms = json['terms'];
    status = json['status'];
    hash = json['hash'];
    location = json['location'];
    hasActiveTransactions = json['hasActiveTransactions'];
    isPublic = json['isPublic'];
    //community = json['community'] != null
    //    ? new Community.fromJson(json['community'])
    //  : null;
  }
}

class Buyer {
  int? userId;
  late String wallet;
  String? email;

  Null? name;
  String? userName;
  String? telegram;
  String? minifiedWallet;
  UserScoring? userScoring;
  bool? whitelist;
  bool? plan;
  int? planId;
  // Null? language;
  int? cryptoId;
  int? fiatCoinId;
  int? blockchainId;

  Buyer(
      {userId,
      wallet,
      email,
      name,
      userName,
      telegram,
      minifiedWallet,
      userScoring,
      whitelist,
      plan,
      planId,
      //language,
      cryptoId,
      fiatCoinId,
      blockchainId});

  Buyer.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    wallet = json['wallet'];
    email = json['email'];

    name = json['name'];
    userName = json['userName'];
    telegram = json['telegram'];
    minifiedWallet = json['minifiedWallet'];
    userScoring = json['userScoring'] != null
        ? new UserScoring.fromJson(json['userScoring'])
        : null;
    whitelist = json['whitelist'];
    plan = json['plan'];
    planId = json['planId'];
    // language = json['language'];
    cryptoId = json['cryptoId'];
    fiatCoinId = json['fiatCoinId'];
    blockchainId = json['blockchainId'];
  }
}

class UserScoring {
  int? totalTransaction;
  double? totalAmount;
  double? averagePaymentTime;
  double? averageReleaseTime;

  int? lastTransactions;
  int? positiveOpinions;
  int? negativeOpinions;
  double? positiveOpinionPercentage;

/*
  String? dateFirstTransaction;
  int? totalOpinions;
  double? lastFifteen;
  double? totalAmountOfThisMonth;
  double? appealedTransactions;
*/
  UserScoring({
    totalTransaction,
    totalAmount,
    averagePaymentTime,
    averageReleaseTime,
    lastTransactions,
    positiveOpinions,
    negativeOpinions,
    positiveOpinionPercentage,
    /*
      dateFirstTransaction,
      totalOpinions,
      lastFifteen,
      totalAmountOfThisMonth,
      appealedTransactions
      */
  });

  UserScoring.fromJson(Map<String, dynamic> json) {
    totalTransaction = json['totalTransaction'];
    totalAmount = json['totalAmount'];
    averagePaymentTime = json['averagePaymentTime'];
    averageReleaseTime = json['averageReleaseTime'];

    lastTransactions = json['lastTransactions'];
    positiveOpinions = json['positiveOpinions'];
    negativeOpinions = json['negativeOpinions'];
    positiveOpinionPercentage = json['positiveOpinionPercentage'];
    /*
    dateFirstTransaction = json['dateFirstTransaction'];
    totalOpinions = json['totalOpinions'];
    lastFifteen = json['lastFifteen'];
    totalAmountOfThisMonth = json['totalAmountOfThisMonth'];
    appealedTransactions = json['appealedTransactions'];*/
  }
}

class Crypto {
  int? cryptoId;
  String? description;
  String? address;
  String? symbol;
  int? blockchainId;
  Blockchain? blockchain;
  int? decimal;
  String? pathImage;
  bool? native;

  Crypto(
      {cryptoId,
      description,
      address,
      symbol,
      blockchainId,
      blockchain,
      decimal,
      pathImage,
      native});

  Crypto.fromJson(Map<String, dynamic> json) {
    cryptoId = json['cryptoId'];
    description = json['description'];
    address = json['address'];
    symbol = json['symbol'];
    blockchainId = json['blockchainId'];
    blockchain = json['blockchain'] != null
        ? new Blockchain.fromJson(json['blockchain'])
        : null;
    decimal = json['decimal'];
    pathImage = json['pathImage'];
    native = json['native'];
  }
}

class Blockchain {
  int? blockchainId;
  String? description;
  String? url;
  String? escrowContract;
  int? chainId;
  String? coin;
  String? scan;
  String? pathImage;

  Blockchain(
      {blockchainId,
      description,
      url,
      escrowContract,
      chainId,
      coin,
      scan,
      pathImage});

  Blockchain.fromJson(Map<String, dynamic> json) {
    blockchainId = json['blockchainId'];
    description = json['description'];
    url = json['url'];
    escrowContract = json['escrowContract'];
    chainId = json['chainId'];
    coin = json['coin'];
    scan = json['scan'];
    pathImage = json['pathImage'];
  }
}

class FiatCoin {
  int? fiatCoinId;
  String? description;
  String? symbol;
  String? pathImage;

  FiatCoin({fiatCoinId, description, symbol, pathImage});

  FiatCoin.fromJson(Map<String, dynamic> json) {
    fiatCoinId = json['fiatCoinId'];
    description = json['description'];
    symbol = json['symbol'];
    pathImage = json['pathImage'];
  }
}

class Community {
  int? communityId;
  Owner? owner;
  String? name;
  String? description;
  String? contact;
  String? youtube;
  String? telegram;
  String? discord;
  String? twitter;
  String? imageUri;
  double? monthlyVolume;
  double? monthlyCommission;
  double? totalVolume;
  int? communityMembersCount;

  Community(
      {communityId,
      owner,
      name,
      description,
      contact,
      youtube,
      telegram,
      discord,
      twitter,
      imageUri,
      monthlyVolume,
      monthlyCommission,
      totalVolume,
      communityMembersCount});

  Community.fromJson(Map<String, dynamic> json) {
    communityId = json['communityId'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    name = json['name'];
    description = json['description'];
    contact = json['contact'];
    youtube = json['youtube'];
    telegram = json['telegram'];
    discord = json['discord'];
    twitter = json['twitter'];
    imageUri = json['imageUri'];
    monthlyVolume = json['monthlyVolume'];
    monthlyCommission = json['monthlyCommission'];
    totalVolume = json['totalVolume'];
    communityMembersCount = json['communityMembersCount'];
  }
}

class Owner {
  int? userId;
  String? wallet;
  String? email;
  Null? name;
  String? userName;
  String? telegram;
  String? minifiedWallet;
  UserScoring? userScoring;
  bool? whitelist;
  Null? plan;
  Null? planId;
  String? language;
  int? cryptoId;
  int? fiatCoinId;
  int? blockchainId;

  Owner(
      {userId,
      wallet,
      email,
      name,
      userName,
      telegram,
      minifiedWallet,
      userScoring,
      whitelist,
      plan,
      planId,
      language,
      cryptoId,
      fiatCoinId,
      blockchainId});

  Owner.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    wallet = json['wallet'];
    email = json['email'];
    name = json['name'];
    userName = json['userName'];
    telegram = json['telegram'];
    minifiedWallet = json['minifiedWallet'];
    userScoring = json['userScoring'] != null
        ? new UserScoring.fromJson(json['userScoring'])
        : null;
    whitelist = json['whitelist'];
    plan = json['plan'];
    planId = json['planId'];
    language = json['language'];
    cryptoId = json['cryptoId'];
    fiatCoinId = json['fiatCoinId'];
    blockchainId = json['blockchainId'];
  }
}
