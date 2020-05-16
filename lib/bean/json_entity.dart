import 'package:json_annotation/json_annotation.dart';

part 'json_entity.g.dart';

@JsonSerializable()
class BaseEntity {
  @JsonKey(defaultValue: false)
  bool success;

  BaseEntity(this.success, this.errorCode, this.msg, this.body);

  @JsonKey(defaultValue: "0")
  String errorCode;
  @JsonKey(defaultValue: "")
  String msg;
  dynamic body;

  factory BaseEntity.fromJson(Map<String, dynamic> json) =>
      _$BaseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BaseEntityToJson(this);

  BodyObject toBody() {
    return BodyObject.fromJson(body);
  }
}

@JsonSerializable()
class BodyObject {
  dynamic data;

  BodyObject(this.data);

  factory BodyObject.fromJson(Map<String, dynamic> json) =>
      _$BodyObjectFromJson(json);

  Map<String, dynamic> toJson() => _$BodyObjectToJson(this);

  GoodsDetailsEntity toGoodsDetails() {
    return GoodsDetailsEntity.fromJson(data);
  }
}

@JsonSerializable()
class GoodsDetailsEntity {
  @JsonKey(defaultValue: "")
  String id;
  @JsonKey(defaultValue: "")
  String name;
  @JsonKey(defaultValue: "")
  String title;
  @JsonKey(defaultValue: "")
  String description;
  @JsonKey(defaultValue: "")
  String content;
  @JsonKey(defaultValue: "")
  String categoryId;
  @JsonKey(defaultValue: "")
  String subCategoryId;
  @JsonKey(defaultValue: 0)
  double price;
  @JsonKey(defaultValue: 0)
  double originalPrice;
  @JsonKey(defaultValue: "")
  String fileUrl;
  @JsonKey()
  dynamic recommendFlag;
  @JsonKey()
  dynamic recommendSort;
  @JsonKey(defaultValue: "")
  String categoryName;
  @JsonKey(defaultValue: {})
  PostageTemplateEntity postageTemplate;
  @JsonKey(defaultValue: 0)
  int unconditionalRefundFlag;
  @JsonKey(defaultValue: 0)
  int source;
  @JsonKey(defaultValue: 0)
  int onFlag;
  @JsonKey(defaultValue: {})
  GoodsPropertyEntity goodsProperty;
  @JsonKey(defaultValue: [])
  List<GoodsPropertyEntity> goodsPropertyList;

  GoodsDetailsEntity(
      this.id,
      this.name,
      this.title,
      this.description,
      this.content,
      this.categoryId,
      this.subCategoryId,
      this.price,
      this.originalPrice,
      this.fileUrl,
      this.recommendFlag,
      this.recommendSort,
      this.categoryName,
      this.postageTemplate,
      this.unconditionalRefundFlag,
      this.source,
      this.onFlag,
      this.goodsProperty,
      this.goodsPropertyList,
      this.picUrl,
      this.shop);

  String picUrl;
  ShopEntity shop;

  factory GoodsDetailsEntity.fromJson(Map<String, dynamic> json) =>
      _$GoodsDetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GoodsDetailsEntityToJson(this);
}

@JsonSerializable()
class ShopEntity {
  factory ShopEntity.fromJson(Map<String, dynamic> json) =>
      _$ShopEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ShopEntityToJson(this);
  @JsonKey(defaultValue: "")
  String id;
  @JsonKey(defaultValue: "")
  String parentIds;
  @JsonKey(defaultValue: "")
  String name;
  @JsonKey(defaultValue: 0)
  int sort;
  @JsonKey(defaultValue: "")
  String type;
  @JsonKey(defaultValue: "")
  String parentId;

  ShopEntity(
      this.id, this.parentIds, this.name, this.sort, this.type, this.parentId);
}

@JsonSerializable()
class PostageTemplateEntity {
  @JsonKey(defaultValue: "")
  String name;

  PostageTemplateEntity(this.name);

  factory PostageTemplateEntity.fromJson(Map<String, dynamic> json) =>
      _$PostageTemplateEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PostageTemplateEntityToJson(this);
}

@JsonSerializable()
class GoodsPropertyEntity {
  @JsonKey(defaultValue: "")
  String id;
  @JsonKey(defaultValue: "")
  String name;
  @JsonKey(defaultValue: 0)
  double price;
  @JsonKey(defaultValue: 0)
  int stock;

  GoodsPropertyEntity(this.id, this.name, this.price, this.stock);

  factory GoodsPropertyEntity.fromJson(Map<String, dynamic> json) =>
      _$GoodsPropertyEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GoodsPropertyEntityToJson(this);
}

@JsonSerializable()
class OrderCountEntity {
  @JsonKey(
    defaultValue: 0,
  )
  int package;

  OrderCountEntity(this.package, this.pay, this.unpay, this.canRefund,
      this.evaluate, this.refund);

  @JsonKey(
    defaultValue: 0,
  )
  int pay;
  @JsonKey(
    defaultValue: 0,
  )
  int unpay;
  @JsonKey(
    defaultValue: 0,
  )
  int canRefund;
  @JsonKey(
    defaultValue: 0,
  )
  int evaluate;
  @JsonKey(
    defaultValue: 0,
  )
  int refund;

  factory OrderCountEntity.fromJson(Map<String, dynamic> map) {
    return _$OrderCountEntityFromJson(map);
  }

  Map<String, dynamic> toJson() => _$OrderCountEntityToJson(this);
}

@JsonSerializable()
class LoginBody {
  @JsonKey()
  String token;
  @JsonKey()
  UserEntity user;

  LoginBody(this.token, this.user);

  factory LoginBody.fromJson(Map<String, dynamic> json) =>
      _$LoginBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LoginBodyToJson(this);
}

@JsonSerializable()
class UserEntity {
  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  String id;
  String loginName;
  String realName;
  String mobile;
  int state;

  UserEntity(this.id, this.loginName, this.realName, this.mobile, this.state,
      this.nickname, this.avatar, this.userType);

  String nickname;
  String avatar;
  int userType;

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}

@JsonSerializable()
class ContactEntity {
  String id;

  ContactEntity(
      this.id, this.name, this.eigenvalue, this.mobile, this.imageSrc);

  String name;
  String eigenvalue;
  String mobile;
  String imageSrc;

  factory ContactEntity.fromJson(Map<String, dynamic> json) =>
      _$ContactEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ContactEntityToJson(this);
}

@JsonSerializable()
class ContactsListEntity {
  List<ContactEntity> data;

  ContactsListEntity(this.data);

  factory ContactsListEntity.fromJson(Map<String, dynamic> json) =>
      _$ContactsListEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ContactsListEntityToJson(this);
}

@JsonSerializable()
class CategoryListEntity {
  List<CategoryEntity> data;

  CategoryListEntity(this.data);

  factory CategoryListEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryListEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryListEntityToJson(this);
}

@JsonSerializable()
class CategoryEntity {
  String id;

  CategoryEntity(this.id, this.name, this.parentId, this.source, this.sort);

  factory CategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryEntityToJson(this);

  String name;
  String parentId;
  int source;
  int sort;
}

@JsonSerializable()
class GoodsListEntity {
  int pageNo;
  int pageSize;
  int count;
  List<GoodsEntity> list;

  GoodsListEntity(this.pageNo, this.pageSize, this.count, this.list);

  factory GoodsListEntity.fromJson(Map<String, dynamic> json) =>
      _$GoodsListEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GoodsListEntityToJson(this);
}

@JsonSerializable()
class GoodsEntity {
  String id;
  String name;
  String title;
  String description;
  String categoryId;
  String subCategoryId;

  GoodsEntity(
      this.id,
      this.name,
      this.title,
      this.description,
      this.categoryId,
      this.subCategoryId,
      this.price,
      this.originalPrice,
      this.picUrl,
      this.goodsProperty,
      this.goodsPropertyList,
      this.shop,
      this.source);

  double price;
  double originalPrice;
  String picUrl;
  GoodsPropertyEntity goodsProperty;
  List<GoodsPropertyEntity> goodsPropertyList;
  ShopEntity shop;
  int source;


  factory GoodsEntity.fromJson(Map<String, dynamic> json) =>
      _$GoodsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GoodsEntityToJson(this);
}

@JsonSerializable()
class GoodsCategoryListEntity {
  int pageNo;
  int pageSize;
  int count;
  List<GoodsCategoryEntity> data;

  GoodsCategoryListEntity(this.pageNo, this.pageSize, this.count, this.data);

  factory GoodsCategoryListEntity.fromJson(Map<String, dynamic> json) =>
      _$GoodsCategoryListEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GoodsCategoryListEntityToJson(this);
}

@JsonSerializable()
class GoodsCategoryEntity {
  String id;
  String name;
  String parentId;
  int sort;

  GoodsCategoryEntity(
    this.id,
    this.name,
    this.parentId,
    this.sort,
  );

  factory GoodsCategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$GoodsCategoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GoodsCategoryEntityToJson(this);
}

@JsonSerializable()
class SettingsEntity {
  String id;
  String privateProtocol;
  String andriodVersion;
  String andriodFile;

  String aboutUs;
  int forceUpdate;
  String updateInfo;
  String andriodFileSize;

  SettingsEntity(
      this.id,
      this.privateProtocol,
      this.andriodVersion,
      this.andriodFile,
      this.aboutUs,
      this.forceUpdate,
      this.updateInfo,
      this.andriodFileSize,
      this.test);

  bool test;

  factory SettingsEntity.fromJson(Map<String, dynamic> json) =>
      _$SettingsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsEntityToJson(this);
}

@JsonSerializable()
class OrderListEntity {
  int pageNo;
  int pageSize;

  OrderListEntity(this.pageNo, this.pageSize, this.count, this.list);

  factory OrderListEntity.fromJson(Map<String, dynamic> json) =>
      _$OrderListEntityFromJson(json);
  int count;
  List<OrderEntity> list;
}

@JsonSerializable()
class OrderEntity {
  String id;
  int orderNumber;
  ShopEntity shop;
  double totalFee;

  OrderEntity(
      this.id,
      this.orderNumber,
      this.shop,
      this.totalFee,
      this.realFee,
      this.freightFee,
      this.state,
      this.payOrderId,
      this.refundOrderId,
      this.logisticsNo,
      this.logisticsType,
      this.logisticsName,
      this.goodsAmount,
      this.details,
      this.address);

  double realFee;
  double freightFee;
  int state;
  String payOrderId;
  String refundOrderId;
  String logisticsNo;
  String logisticsType;
  String logisticsName;
  int goodsAmount;
  List<OrderDetailsEntity> details;
  AddressEntity address;

  factory OrderEntity.fromJson(Map<String, dynamic> json) =>
      _$OrderEntityFromJson(json);
}

@JsonSerializable()
class AddressEntity {
  String id;
  String mobile;
  String name;
  String city;
  String detail;
  int defaultFlag;

  AddressEntity(this.id, this.mobile, this.name, this.city, this.detail,
      this.defaultFlag);

  factory AddressEntity.fromJson(Map<String, dynamic> json) =>
      _$AddressEntityFromJson(json);
}

@JsonSerializable()
class OrderDetailsEntity {
  GoodsEntity goodsInfo;
  int amount;

  OrderDetailsEntity(this.goodsInfo, this.amount, this.totalFee,
      this.goodsPropertyName, this.shop);

  double totalFee;
  String goodsPropertyName;
  ShopEntity shop;

  factory OrderDetailsEntity.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsEntityFromJson(json);
}

@JsonSerializable()
class GuardianListEntity {
  List<GuardianEntity> list;
  int pageNo;
  int pageSize;

  GuardianListEntity(this.list, this.pageNo, this.pageSize, this.count);

  int count;

  factory GuardianListEntity.fromJson(Map<String, dynamic> json) =>
      _$GuardianListEntityFromJson(json);
}

@JsonSerializable()
class GuardianEntity {
  String id;

  GuardianEntity(this.id, this.userInfo);

  UserEntity userInfo;

  factory GuardianEntity.fromJson(Map<String, dynamic> json) =>
      _$GuardianEntityFromJson(json);
}

@JsonSerializable()
class GoodsCartEntity {
  String id;
  ShopEntity shop;
  List<CartEntity> details;

  GoodsCartEntity(this.id, this.shop, this.details);
  factory GoodsCartEntity.fromJson(Map<String,dynamic>json)=>_$GoodsCartEntityFromJson(json);
}

@JsonSerializable()
class GoodsCartListEntity {
  int pageNo;

  GoodsCartListEntity(this.pageNo, this.pageSize, this.count, this.list);

  int pageSize;
  int count;
  List<GoodsCartEntity> list;

  factory GoodsCartListEntity.fromJson(Map<String,dynamic>json)=>_$GoodsCartListEntityFromJson(json);
}

@JsonSerializable()
class CartEntity {
  int amount;
  String id;
  String userId;
  String shopId;
  String goodsId;

  CartEntity(this.amount, this.id, this.userId, this.shopId, this.goodsId,
      this.propertyId, this.goodsInfo, this.goodsProperty, this.cartIds);

  String propertyId;
  GoodsEntity goodsInfo;
  GoodsPropertyEntity goodsProperty;
  String cartIds;

  factory CartEntity.fromJson(Map<String,dynamic>json)=>_$CartEntityFromJson(json);
}
@JsonSerializable()
class ModifyCartEntity{
  String id;
  int amount;

  ModifyCartEntity(this.id, this.amount);

  factory ModifyCartEntity.fromJson(Map<String,dynamic>json)=>_$ModifyCartEntityFromJson(json);
}

@JsonSerializable()
class WeatherEntity{
  List<WeatherResult> results;

  WeatherEntity(this.results);

  factory WeatherEntity.fromJson(Map<String,dynamic>json)=>_$WeatherEntityFromJson(json);
}

@JsonSerializable()
class WeatherResult {
  dynamic now;
  factory WeatherResult.fromJson(Map<String,dynamic>json)=>_$WeatherResultFromJson(json);

  WeatherResult(this.now);

  String getTemperature(){
   return now['temperature'];
  }

  String getText(){
    return now['text'];
  }
}