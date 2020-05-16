// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseEntity _$BaseEntityFromJson(Map<String, dynamic> json) {
  return BaseEntity(
    json['success'] as bool ?? false,
    json['errorCode'] as String ?? '0',
    json['msg'] as String ?? '',
    json['body'],
  );
}

Map<String, dynamic> _$BaseEntityToJson(BaseEntity instance) =>
    <String, dynamic>{
      'success': instance.success,
      'errorCode': instance.errorCode,
      'msg': instance.msg,
      'body': instance.body,
    };

BodyObject _$BodyObjectFromJson(Map<String, dynamic> json) {
  return BodyObject(
    json['data'],
  );
}

Map<String, dynamic> _$BodyObjectToJson(BodyObject instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

GoodsDetailsEntity _$GoodsDetailsEntityFromJson(Map<String, dynamic> json) {
  return GoodsDetailsEntity(
    json['id'] as String ?? '',
    json['name'] as String ?? '',
    json['title'] as String ?? '',
    json['description'] as String ?? '',
    json['content'] as String ?? '',
    json['categoryId'] as String ?? '',
    json['subCategoryId'] as String ?? '',
    (json['price'] as num)?.toDouble() ?? 0,
    (json['originalPrice'] as num)?.toDouble() ?? 0,
    json['fileUrl'] as String ?? '',
    json['recommendFlag'],
    json['recommendSort'],
    json['categoryName'] as String ?? '',
    json['postageTemplate'] == null
        ? null
        : PostageTemplateEntity.fromJson(
                json['postageTemplate'] as Map<String, dynamic>) ??
            {},
    json['unconditionalRefundFlag'] as int ?? 0,
    json['source'] as int ?? 0,
    json['onFlag'] as int ?? 0,
    json['goodsProperty'] == null
        ? null
        : GoodsPropertyEntity.fromJson(
                json['goodsProperty'] as Map<String, dynamic>) ??
            {},
    (json['goodsPropertyList'] as List)
            ?.map((e) => e == null
                ? null
                : GoodsPropertyEntity.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    json['picUrl'] as String,
    json['shop'] == null
        ? null
        : ShopEntity.fromJson(json['shop'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GoodsDetailsEntityToJson(GoodsDetailsEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'description': instance.description,
      'content': instance.content,
      'categoryId': instance.categoryId,
      'subCategoryId': instance.subCategoryId,
      'price': instance.price,
      'originalPrice': instance.originalPrice,
      'fileUrl': instance.fileUrl,
      'recommendFlag': instance.recommendFlag,
      'recommendSort': instance.recommendSort,
      'categoryName': instance.categoryName,
      'postageTemplate': instance.postageTemplate,
      'unconditionalRefundFlag': instance.unconditionalRefundFlag,
      'source': instance.source,
      'onFlag': instance.onFlag,
      'goodsProperty': instance.goodsProperty,
      'goodsPropertyList': instance.goodsPropertyList,
      'picUrl': instance.picUrl,
      'shop': instance.shop,
    };

ShopEntity _$ShopEntityFromJson(Map<String, dynamic> json) {
  return ShopEntity(
    json['id'] as String ?? '',
    json['parentIds'] as String ?? '',
    json['name'] as String ?? '',
    json['sort'] as int ?? 0,
    json['type'] as String ?? '',
    json['parentId'] as String ?? '',
  );
}

Map<String, dynamic> _$ShopEntityToJson(ShopEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parentIds': instance.parentIds,
      'name': instance.name,
      'sort': instance.sort,
      'type': instance.type,
      'parentId': instance.parentId,
    };

PostageTemplateEntity _$PostageTemplateEntityFromJson(
    Map<String, dynamic> json) {
  return PostageTemplateEntity(
    json['name'] as String ?? '',
  );
}

Map<String, dynamic> _$PostageTemplateEntityToJson(
        PostageTemplateEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

GoodsPropertyEntity _$GoodsPropertyEntityFromJson(Map<String, dynamic> json) {
  return GoodsPropertyEntity(
    json['id'] as String ?? '',
    json['name'] as String ?? '',
    (json['price'] as num)?.toDouble() ?? 0,
    json['stock'] as int ?? 0,
  );
}

Map<String, dynamic> _$GoodsPropertyEntityToJson(
        GoodsPropertyEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'stock': instance.stock,
    };

OrderCountEntity _$OrderCountEntityFromJson(Map<String, dynamic> json) {
  return OrderCountEntity(
    json['package'] as int ?? 0,
    json['pay'] as int ?? 0,
    json['unpay'] as int ?? 0,
    json['canRefund'] as int ?? 0,
    json['evaluate'] as int ?? 0,
    json['refund'] as int ?? 0,
  );
}

Map<String, dynamic> _$OrderCountEntityToJson(OrderCountEntity instance) =>
    <String, dynamic>{
      'package': instance.package,
      'pay': instance.pay,
      'unpay': instance.unpay,
      'canRefund': instance.canRefund,
      'evaluate': instance.evaluate,
      'refund': instance.refund,
    };

LoginBody _$LoginBodyFromJson(Map<String, dynamic> json) {
  return LoginBody(
    json['token'] as String,
    json['user'] == null
        ? null
        : UserEntity.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LoginBodyToJson(LoginBody instance) => <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) {
  return UserEntity(
    json['id'] as String,
    json['loginName'] as String,
    json['realName'] as String,
    json['mobile'] as String,
    json['state'] as int,
    json['nickname'] as String,
    json['avatar'] as String,
    json['userType'] as int,
  );
}

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'loginName': instance.loginName,
      'realName': instance.realName,
      'mobile': instance.mobile,
      'state': instance.state,
      'nickname': instance.nickname,
      'avatar': instance.avatar,
      'userType': instance.userType,
    };

ContactEntity _$ContactEntityFromJson(Map<String, dynamic> json) {
  return ContactEntity(
    json['id'] as String,
    json['name'] as String,
    json['eigenvalue'] as String,
    json['mobile'] as String,
    json['imageSrc'] as String,
  );
}

Map<String, dynamic> _$ContactEntityToJson(ContactEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'eigenvalue': instance.eigenvalue,
      'mobile': instance.mobile,
      'imageSrc': instance.imageSrc,
    };

ContactsListEntity _$ContactsListEntityFromJson(Map<String, dynamic> json) {
  return ContactsListEntity(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ContactEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ContactsListEntityToJson(ContactsListEntity instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

CategoryListEntity _$CategoryListEntityFromJson(Map<String, dynamic> json) {
  return CategoryListEntity(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : CategoryEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CategoryListEntityToJson(CategoryListEntity instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

CategoryEntity _$CategoryEntityFromJson(Map<String, dynamic> json) {
  return CategoryEntity(
    json['id'] as String,
    json['name'] as String,
    json['parentId'] as String,
    json['source'] as int,
    json['sort'] as int,
  );
}

Map<String, dynamic> _$CategoryEntityToJson(CategoryEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'parentId': instance.parentId,
      'source': instance.source,
      'sort': instance.sort,
    };

GoodsListEntity _$GoodsListEntityFromJson(Map<String, dynamic> json) {
  return GoodsListEntity(
    json['pageNo'] as int,
    json['pageSize'] as int,
    json['count'] as int,
    (json['list'] as List)
        ?.map((e) =>
            e == null ? null : GoodsEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GoodsListEntityToJson(GoodsListEntity instance) =>
    <String, dynamic>{
      'pageNo': instance.pageNo,
      'pageSize': instance.pageSize,
      'count': instance.count,
      'list': instance.list,
    };

GoodsEntity _$GoodsEntityFromJson(Map<String, dynamic> json) {
  return GoodsEntity(
    json['id'] as String,
    json['name'] as String,
    json['title'] as String,
    json['description'] as String,
    json['categoryId'] as String,
    json['subCategoryId'] as String,
    (json['price'] as num)?.toDouble(),
    (json['originalPrice'] as num)?.toDouble(),
    json['picUrl'] as String,
    json['goodsProperty'] == null
        ? null
        : GoodsPropertyEntity.fromJson(
            json['goodsProperty'] as Map<String, dynamic>),
    (json['goodsPropertyList'] as List)
        ?.map((e) => e == null
            ? null
            : GoodsPropertyEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['shop'] == null
        ? null
        : ShopEntity.fromJson(json['shop'] as Map<String, dynamic>),
    json['source'] as int,
  );
}

Map<String, dynamic> _$GoodsEntityToJson(GoodsEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'description': instance.description,
      'categoryId': instance.categoryId,
      'subCategoryId': instance.subCategoryId,
      'price': instance.price,
      'originalPrice': instance.originalPrice,
      'picUrl': instance.picUrl,
      'goodsProperty': instance.goodsProperty,
      'goodsPropertyList': instance.goodsPropertyList,
      'shop': instance.shop,
      'source': instance.source,
    };

GoodsCategoryListEntity _$GoodsCategoryListEntityFromJson(
    Map<String, dynamic> json) {
  return GoodsCategoryListEntity(
    json['pageNo'] as int,
    json['pageSize'] as int,
    json['count'] as int,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : GoodsCategoryEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GoodsCategoryListEntityToJson(
        GoodsCategoryListEntity instance) =>
    <String, dynamic>{
      'pageNo': instance.pageNo,
      'pageSize': instance.pageSize,
      'count': instance.count,
      'data': instance.data,
    };

GoodsCategoryEntity _$GoodsCategoryEntityFromJson(Map<String, dynamic> json) {
  return GoodsCategoryEntity(
    json['id'] as String,
    json['name'] as String,
    json['parentId'] as String,
    json['sort'] as int,
  );
}

Map<String, dynamic> _$GoodsCategoryEntityToJson(
        GoodsCategoryEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'parentId': instance.parentId,
      'sort': instance.sort,
    };

SettingsEntity _$SettingsEntityFromJson(Map<String, dynamic> json) {
  return SettingsEntity(
    json['id'] as String,
    json['privateProtocol'] as String,
    json['andriodVersion'] as String,
    json['andriodFile'] as String,
    json['aboutUs'] as String,
    json['forceUpdate'] as int,
    json['updateInfo'] as String,
    json['andriodFileSize'] as String,
    json['test'] as bool,
  );
}

Map<String, dynamic> _$SettingsEntityToJson(SettingsEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'privateProtocol': instance.privateProtocol,
      'andriodVersion': instance.andriodVersion,
      'andriodFile': instance.andriodFile,
      'aboutUs': instance.aboutUs,
      'forceUpdate': instance.forceUpdate,
      'updateInfo': instance.updateInfo,
      'andriodFileSize': instance.andriodFileSize,
      'test': instance.test,
    };

OrderListEntity _$OrderListEntityFromJson(Map<String, dynamic> json) {
  return OrderListEntity(
    json['pageNo'] as int,
    json['pageSize'] as int,
    json['count'] as int,
    (json['list'] as List)
        ?.map((e) =>
            e == null ? null : OrderEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OrderListEntityToJson(OrderListEntity instance) =>
    <String, dynamic>{
      'pageNo': instance.pageNo,
      'pageSize': instance.pageSize,
      'count': instance.count,
      'list': instance.list,
    };

OrderEntity _$OrderEntityFromJson(Map<String, dynamic> json) {
  return OrderEntity(
    json['id'] as String,
    json['orderNumber'] as int,
    json['shop'] == null
        ? null
        : ShopEntity.fromJson(json['shop'] as Map<String, dynamic>),
    (json['totalFee'] as num)?.toDouble(),
    (json['realFee'] as num)?.toDouble(),
    (json['freightFee'] as num)?.toDouble(),
    json['state'] as int,
    json['payOrderId'] as String,
    json['refundOrderId'] as String,
    json['logisticsNo'] as String,
    json['logisticsType'] as String,
    json['logisticsName'] as String,
    json['goodsAmount'] as int,
    (json['details'] as List)
        ?.map((e) => e == null
            ? null
            : OrderDetailsEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['address'] == null
        ? null
        : AddressEntity.fromJson(json['address'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OrderEntityToJson(OrderEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderNumber': instance.orderNumber,
      'shop': instance.shop,
      'totalFee': instance.totalFee,
      'realFee': instance.realFee,
      'freightFee': instance.freightFee,
      'state': instance.state,
      'payOrderId': instance.payOrderId,
      'refundOrderId': instance.refundOrderId,
      'logisticsNo': instance.logisticsNo,
      'logisticsType': instance.logisticsType,
      'logisticsName': instance.logisticsName,
      'goodsAmount': instance.goodsAmount,
      'details': instance.details,
      'address': instance.address,
    };

AddressEntity _$AddressEntityFromJson(Map<String, dynamic> json) {
  return AddressEntity(
    json['id'] as String,
    json['mobile'] as String,
    json['name'] as String,
    json['city'] as String,
    json['detail'] as String,
    json['defaultFlag'] as int,
  );
}

Map<String, dynamic> _$AddressEntityToJson(AddressEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mobile': instance.mobile,
      'name': instance.name,
      'city': instance.city,
      'detail': instance.detail,
      'defaultFlag': instance.defaultFlag,
    };

OrderDetailsEntity _$OrderDetailsEntityFromJson(Map<String, dynamic> json) {
  return OrderDetailsEntity(
    json['goodsInfo'] == null
        ? null
        : GoodsEntity.fromJson(json['goodsInfo'] as Map<String, dynamic>),
    json['amount'] as int,
    (json['totalFee'] as num)?.toDouble(),
    json['goodsPropertyName'] as String,
    json['shop'] == null
        ? null
        : ShopEntity.fromJson(json['shop'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OrderDetailsEntityToJson(OrderDetailsEntity instance) =>
    <String, dynamic>{
      'goodsInfo': instance.goodsInfo,
      'amount': instance.amount,
      'totalFee': instance.totalFee,
      'goodsPropertyName': instance.goodsPropertyName,
      'shop': instance.shop,
    };

GuardianListEntity _$GuardianListEntityFromJson(Map<String, dynamic> json) {
  return GuardianListEntity(
    (json['list'] as List)
        ?.map((e) => e == null
            ? null
            : GuardianEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['pageNo'] as int,
    json['pageSize'] as int,
    json['count'] as int,
  );
}

Map<String, dynamic> _$GuardianListEntityToJson(GuardianListEntity instance) =>
    <String, dynamic>{
      'list': instance.list,
      'pageNo': instance.pageNo,
      'pageSize': instance.pageSize,
      'count': instance.count,
    };

GuardianEntity _$GuardianEntityFromJson(Map<String, dynamic> json) {
  return GuardianEntity(
    json['id'] as String,
    json['userInfo'] == null
        ? null
        : UserEntity.fromJson(json['userInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GuardianEntityToJson(GuardianEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userInfo': instance.userInfo,
    };

GoodsCartEntity _$GoodsCartEntityFromJson(Map<String, dynamic> json) {
  return GoodsCartEntity(
    json['id'] as String,
    json['shop'] == null
        ? null
        : ShopEntity.fromJson(json['shop'] as Map<String, dynamic>),
    (json['details'] as List)
        ?.map((e) =>
            e == null ? null : CartEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GoodsCartEntityToJson(GoodsCartEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shop': instance.shop,
      'details': instance.details,
    };

GoodsCartListEntity _$GoodsCartListEntityFromJson(Map<String, dynamic> json) {
  return GoodsCartListEntity(
    json['pageNo'] as int,
    json['pageSize'] as int,
    json['count'] as int,
    (json['list'] as List)
        ?.map((e) => e == null
            ? null
            : GoodsCartEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GoodsCartListEntityToJson(
        GoodsCartListEntity instance) =>
    <String, dynamic>{
      'pageNo': instance.pageNo,
      'pageSize': instance.pageSize,
      'count': instance.count,
      'list': instance.list,
    };

CartEntity _$CartEntityFromJson(Map<String, dynamic> json) {
  return CartEntity(
    json['amount'] as int,
    json['id'] as String,
    json['userId'] as String,
    json['shopId'] as String,
    json['goodsId'] as String,
    json['propertyId'] as String,
    json['goodsInfo'] == null
        ? null
        : GoodsEntity.fromJson(json['goodsInfo'] as Map<String, dynamic>),
    json['goodsProperty'] == null
        ? null
        : GoodsPropertyEntity.fromJson(
            json['goodsProperty'] as Map<String, dynamic>),
    json['cartIds'] as String,
  );
}

Map<String, dynamic> _$CartEntityToJson(CartEntity instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'id': instance.id,
      'userId': instance.userId,
      'shopId': instance.shopId,
      'goodsId': instance.goodsId,
      'propertyId': instance.propertyId,
      'goodsInfo': instance.goodsInfo,
      'goodsProperty': instance.goodsProperty,
      'cartIds': instance.cartIds,
    };

ModifyCartEntity _$ModifyCartEntityFromJson(Map<String, dynamic> json) {
  return ModifyCartEntity(
    json['id'] as String,
    json['amount'] as int,
  );
}

Map<String, dynamic> _$ModifyCartEntityToJson(ModifyCartEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
    };

WeatherEntity _$WeatherEntityFromJson(Map<String, dynamic> json) {
  return WeatherEntity(
    (json['results'] as List)
        ?.map((e) => e == null
            ? null
            : WeatherResult.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$WeatherEntityToJson(WeatherEntity instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

WeatherResult _$WeatherResultFromJson(Map<String, dynamic> json) {
  return WeatherResult(
    json['now'],
  );
}

Map<String, dynamic> _$WeatherResultToJson(WeatherResult instance) =>
    <String, dynamic>{
      'now': instance.now,
    };
