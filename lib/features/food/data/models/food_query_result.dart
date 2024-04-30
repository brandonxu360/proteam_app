// Json Parser for food queries from FoodData Central API
// To parse this JSON data, do
//
//     final foodQueryResult = foodQueryResultFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

FoodQueryResult foodQueryResultFromJson(String str) => FoodQueryResult.fromJson(json.decode(str));

String foodQueryResultToJson(FoodQueryResult data) => json.encode(data.toJson());

class FoodQueryResult {
    int totalHits;
    int currentPage;
    int totalPages;
    List<int> pageList;
    FoodSearchCriteria foodSearchCriteria;
    List<Food> foods;
    Aggregations aggregations;

    FoodQueryResult({
        required this.totalHits,
        required this.currentPage,
        required this.totalPages,
        required this.pageList,
        required this.foodSearchCriteria,
        required this.foods,
        required this.aggregations,
    });

    factory FoodQueryResult.fromJson(Map<String, dynamic> json) => FoodQueryResult(
        totalHits: json["totalHits"],
        currentPage: json["currentPage"],
        totalPages: json["totalPages"],
        pageList: List<int>.from(json["pageList"].map((x) => x)),
        foodSearchCriteria: FoodSearchCriteria.fromJson(json["foodSearchCriteria"]),
        foods: List<Food>.from(json["foods"].map((x) => Food.fromJson(x))),
        aggregations: Aggregations.fromJson(json["aggregations"]),
    );

    Map<String, dynamic> toJson() => {
        "totalHits": totalHits,
        "currentPage": currentPage,
        "totalPages": totalPages,
        "pageList": List<dynamic>.from(pageList.map((x) => x)),
        "foodSearchCriteria": foodSearchCriteria.toJson(),
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "aggregations": aggregations.toJson(),
    };
}

class Aggregations {
    DataTypeClass dataType;
    Nutrients nutrients;

    Aggregations({
        required this.dataType,
        required this.nutrients,
    });

    factory Aggregations.fromJson(Map<String, dynamic> json) => Aggregations(
        dataType: DataTypeClass.fromJson(json["dataType"]),
        nutrients: Nutrients.fromJson(json["nutrients"]),
    );

    Map<String, dynamic> toJson() => {
        "dataType": dataType.toJson(),
        "nutrients": nutrients.toJson(),
    };
}

class DataTypeClass {
    int branded;
    int surveyFndds;
    int srLegacy;
    int foundation;

    DataTypeClass({
        required this.branded,
        required this.surveyFndds,
        required this.srLegacy,
        required this.foundation,
    });

    factory DataTypeClass.fromJson(Map<String, dynamic> json) => DataTypeClass(
        branded: json["Branded"],
        surveyFndds: json["Survey (FNDDS)"],
        srLegacy: json["SR Legacy"],
        foundation: json["Foundation"],
    );

    Map<String, dynamic> toJson() => {
        "Branded": branded,
        "Survey (FNDDS)": surveyFndds,
        "SR Legacy": srLegacy,
        "Foundation": foundation,
    };
}

class Nutrients {
    Nutrients();

    factory Nutrients.fromJson(Map<String, dynamic> json) => Nutrients(
    );

    Map<String, dynamic> toJson() => {
    };
}

class FoodSearchCriteria {
    String query;
    String generalSearchInput;
    int pageNumber;
    int numberOfResultsPerPage;
    int pageSize;
    bool requireAllWords;

    FoodSearchCriteria({
        required this.query,
        required this.generalSearchInput,
        required this.pageNumber,
        required this.numberOfResultsPerPage,
        required this.pageSize,
        required this.requireAllWords,
    });

    factory FoodSearchCriteria.fromJson(Map<String, dynamic> json) => FoodSearchCriteria(
        query: json["query"],
        generalSearchInput: json["generalSearchInput"],
        pageNumber: json["pageNumber"],
        numberOfResultsPerPage: json["numberOfResultsPerPage"],
        pageSize: json["pageSize"],
        requireAllWords: json["requireAllWords"],
    );

    Map<String, dynamic> toJson() => {
        "query": query,
        "generalSearchInput": generalSearchInput,
        "pageNumber": pageNumber,
        "numberOfResultsPerPage": numberOfResultsPerPage,
        "pageSize": pageSize,
        "requireAllWords": requireAllWords,
    };
}

class Food {
    int fdcId;
    String description;
    DataTypeEnum dataType;
    String? gtinUpc;
    DateTime publishedDate;
    String? brandOwner;
    String? brandName;
    String? ingredients;
    MarketCountry? marketCountry;
    FoodCategory foodCategory;
    DateTime? modifiedDate;
    DataSource? dataSource;
    String? packageWeight;
    ServingSizeUnit? servingSizeUnit;
    int? servingSize;
    HouseholdServingFullText? householdServingFullText;
    List<TradeChannel>? tradeChannels;
    String allHighlightFields;
    double score;
    List<dynamic> microbes;
    List<FoodNutrient> foodNutrients;
    List<FinalFoodInputFood> finalFoodInputFoods;
    List<FoodMeasure> foodMeasures;
    List<FoodAttribute> foodAttributes;
    List<FoodAttributeType> foodAttributeTypes;
    List<dynamic> foodVersionIds;
    String? subbrandName;
    String? shortDescription;
    String? commonNames;
    String? additionalDescriptions;
    int? foodCode;
    int? foodCategoryId;
    int? ndbNumber;
    DateTime? mostRecentAcquisitionDate;

    Food({
        required this.fdcId,
        required this.description,
        required this.dataType,
        this.gtinUpc,
        required this.publishedDate,
        this.brandOwner,
        this.brandName,
        this.ingredients,
        this.marketCountry,
        required this.foodCategory,
        this.modifiedDate,
        this.dataSource,
        this.packageWeight,
        this.servingSizeUnit,
        this.servingSize,
        this.householdServingFullText,
        this.tradeChannels,
        required this.allHighlightFields,
        required this.score,
        required this.microbes,
        required this.foodNutrients,
        required this.finalFoodInputFoods,
        required this.foodMeasures,
        required this.foodAttributes,
        required this.foodAttributeTypes,
        required this.foodVersionIds,
        this.subbrandName,
        this.shortDescription,
        this.commonNames,
        this.additionalDescriptions,
        this.foodCode,
        this.foodCategoryId,
        this.ndbNumber,
        this.mostRecentAcquisitionDate,
    });

    factory Food.fromJson(Map<String, dynamic> json) => Food(
        fdcId: json["fdcId"],
        description: json["description"],
        dataType: dataTypeEnumValues.map[json["dataType"]]!,
        gtinUpc: json["gtinUpc"],
        publishedDate: DateTime.parse(json["publishedDate"]),
        brandOwner: json["brandOwner"],
        brandName: json["brandName"],
        ingredients: json["ingredients"],
        marketCountry: marketCountryValues.map[json["marketCountry"]]!,
        foodCategory: foodCategoryValues.map[json["foodCategory"]]!,
        modifiedDate: json["modifiedDate"] == null ? null : DateTime.parse(json["modifiedDate"]),
        dataSource: dataSourceValues.map[json["dataSource"]]!,
        packageWeight: json["packageWeight"],
        servingSizeUnit: servingSizeUnitValues.map[json["servingSizeUnit"]]!,
        servingSize: json["servingSize"],
        householdServingFullText: householdServingFullTextValues.map[json["householdServingFullText"]]!,
        tradeChannels: json["tradeChannels"] == null ? [] : List<TradeChannel>.from(json["tradeChannels"]!.map((x) => tradeChannelValues.map[x]!)),
        allHighlightFields: json["allHighlightFields"],
        score: json["score"]?.toDouble(),
        microbes: List<dynamic>.from(json["microbes"].map((x) => x)),
        foodNutrients: List<FoodNutrient>.from(json["foodNutrients"].map((x) => FoodNutrient.fromJson(x))),
        finalFoodInputFoods: List<FinalFoodInputFood>.from(json["finalFoodInputFoods"].map((x) => FinalFoodInputFood.fromJson(x))),
        foodMeasures: List<FoodMeasure>.from(json["foodMeasures"].map((x) => FoodMeasure.fromJson(x))),
        foodAttributes: List<FoodAttribute>.from(json["foodAttributes"].map((x) => FoodAttribute.fromJson(x))),
        foodAttributeTypes: List<FoodAttributeType>.from(json["foodAttributeTypes"].map((x) => FoodAttributeType.fromJson(x))),
        foodVersionIds: List<dynamic>.from(json["foodVersionIds"].map((x) => x)),
        subbrandName: json["subbrandName"],
        shortDescription: json["shortDescription"],
        commonNames: json["commonNames"],
        additionalDescriptions: json["additionalDescriptions"],
        foodCode: json["foodCode"],
        foodCategoryId: json["foodCategoryId"],
        ndbNumber: json["ndbNumber"],
        mostRecentAcquisitionDate: json["mostRecentAcquisitionDate"] == null ? null : DateTime.parse(json["mostRecentAcquisitionDate"]),
    );

    Map<String, dynamic> toJson() => {
        "fdcId": fdcId,
        "description": description,
        "dataType": dataTypeEnumValues.reverse[dataType],
        "gtinUpc": gtinUpc,
        "publishedDate": "${publishedDate.year.toString().padLeft(4, '0')}-${publishedDate.month.toString().padLeft(2, '0')}-${publishedDate.day.toString().padLeft(2, '0')}",
        "brandOwner": brandOwner,
        "brandName": brandName,
        "ingredients": ingredients,
        "marketCountry": marketCountryValues.reverse[marketCountry],
        "foodCategory": foodCategoryValues.reverse[foodCategory],
        "modifiedDate": "${modifiedDate!.year.toString().padLeft(4, '0')}-${modifiedDate!.month.toString().padLeft(2, '0')}-${modifiedDate!.day.toString().padLeft(2, '0')}",
        "dataSource": dataSourceValues.reverse[dataSource],
        "packageWeight": packageWeight,
        "servingSizeUnit": servingSizeUnitValues.reverse[servingSizeUnit],
        "servingSize": servingSize,
        "householdServingFullText": householdServingFullTextValues.reverse[householdServingFullText],
        "tradeChannels": tradeChannels == null ? [] : List<dynamic>.from(tradeChannels!.map((x) => tradeChannelValues.reverse[x])),
        "allHighlightFields": allHighlightFields,
        "score": score,
        "microbes": List<dynamic>.from(microbes.map((x) => x)),
        "foodNutrients": List<dynamic>.from(foodNutrients.map((x) => x.toJson())),
        "finalFoodInputFoods": List<dynamic>.from(finalFoodInputFoods.map((x) => x.toJson())),
        "foodMeasures": List<dynamic>.from(foodMeasures.map((x) => x.toJson())),
        "foodAttributes": List<dynamic>.from(foodAttributes.map((x) => x.toJson())),
        "foodAttributeTypes": List<dynamic>.from(foodAttributeTypes.map((x) => x.toJson())),
        "foodVersionIds": List<dynamic>.from(foodVersionIds.map((x) => x)),
        "subbrandName": subbrandName,
        "shortDescription": shortDescription,
        "commonNames": commonNames,
        "additionalDescriptions": additionalDescriptions,
        "foodCode": foodCode,
        "foodCategoryId": foodCategoryId,
        "ndbNumber": ndbNumber,
        "mostRecentAcquisitionDate": "${mostRecentAcquisitionDate!.year.toString().padLeft(4, '0')}-${mostRecentAcquisitionDate!.month.toString().padLeft(2, '0')}-${mostRecentAcquisitionDate!.day.toString().padLeft(2, '0')}",
    };
}

enum DataSource {
    LI
}

final dataSourceValues = EnumValues({
    "LI": DataSource.LI
});

enum DataTypeEnum {
    BRANDED,
    FOUNDATION,
    SR_LEGACY,
    SURVEY_FNDDS
}

final dataTypeEnumValues = EnumValues({
    "Branded": DataTypeEnum.BRANDED,
    "Foundation": DataTypeEnum.FOUNDATION,
    "SR Legacy": DataTypeEnum.SR_LEGACY,
    "Survey (FNDDS)": DataTypeEnum.SURVEY_FNDDS
});

class FinalFoodInputFood {
    String foodDescription;
    int gramWeight;
    int id;
    String portionCode;
    PortionDescription portionDescription;
    Unit unit;
    int rank;
    int srCode;
    int value;

    FinalFoodInputFood({
        required this.foodDescription,
        required this.gramWeight,
        required this.id,
        required this.portionCode,
        required this.portionDescription,
        required this.unit,
        required this.rank,
        required this.srCode,
        required this.value,
    });

    factory FinalFoodInputFood.fromJson(Map<String, dynamic> json) => FinalFoodInputFood(
        foodDescription: json["foodDescription"],
        gramWeight: json["gramWeight"],
        id: json["id"],
        portionCode: json["portionCode"],
        portionDescription: portionDescriptionValues.map[json["portionDescription"]]!,
        unit: unitValues.map[json["unit"]]!,
        rank: json["rank"],
        srCode: json["srCode"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "foodDescription": foodDescription,
        "gramWeight": gramWeight,
        "id": id,
        "portionCode": portionCode,
        "portionDescription": portionDescriptionValues.reverse[portionDescription],
        "unit": unitValues.reverse[unit],
        "rank": rank,
        "srCode": srCode,
        "value": value,
    };
}

enum PortionDescription {
    NONE
}

final portionDescriptionValues = EnumValues({
    "NONE": PortionDescription.NONE
});

enum Unit {
    GM
}

final unitValues = EnumValues({
    "GM": Unit.GM
});

class FoodAttributeType {
    FoodAttributeTypeName name;
    Description description;
    int id;
    List<FoodAttribute> foodAttributes;

    FoodAttributeType({
        required this.name,
        required this.description,
        required this.id,
        required this.foodAttributes,
    });

    factory FoodAttributeType.fromJson(Map<String, dynamic> json) => FoodAttributeType(
        name: foodAttributeTypeNameValues.map[json["name"]]!,
        description: descriptionValues.map[json["description"]]!,
        id: json["id"],
        foodAttributes: List<FoodAttribute>.from(json["foodAttributes"].map((x) => FoodAttribute.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": foodAttributeTypeNameValues.reverse[name],
        "description": descriptionValues.reverse[description],
        "id": id,
        "foodAttributes": List<dynamic>.from(foodAttributes.map((x) => x.toJson())),
    };
}

enum Description {
    ADDITIONAL_DESCRIPTIONS_FOR_THE_FOOD,
    ADJUSTMENTS_MADE_TO_FOODS_INCLUDING_MOISTURE_CHANGES,
    CHANGES_THAT_WERE_MADE_TO_THIS_FOOD,
    GENERIC_ATTRIBUTES
}

final descriptionValues = EnumValues({
    "Additional descriptions for the food.": Description.ADDITIONAL_DESCRIPTIONS_FOR_THE_FOOD,
    "Adjustments made to foods, including moisture changes": Description.ADJUSTMENTS_MADE_TO_FOODS_INCLUDING_MOISTURE_CHANGES,
    "Changes that were made to this food": Description.CHANGES_THAT_WERE_MADE_TO_THIS_FOOD,
    "Generic attributes": Description.GENERIC_ATTRIBUTES
});

class FoodAttribute {
    String value;
    FoodAttributeName? name;
    int id;
    int? sequenceNumber;

    FoodAttribute({
        required this.value,
        this.name,
        required this.id,
        this.sequenceNumber,
    });

    factory FoodAttribute.fromJson(Map<String, dynamic> json) => FoodAttribute(
        value: json["value"],
        name: foodAttributeNameValues.map[json["name"]]!,
        id: json["id"],
        sequenceNumber: json["sequenceNumber"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "name": foodAttributeNameValues.reverse[name],
        "id": id,
        "sequenceNumber": sequenceNumber,
    };
}

enum FoodAttributeName {
    FOOD_DISCONTINUED,
    INGREDIENTS,
    WWEIA_CATEGORY_DESCRIPTION,
    WWEIA_CATEGORY_NUMBER
}

final foodAttributeNameValues = EnumValues({
    "Food Discontinued": FoodAttributeName.FOOD_DISCONTINUED,
    "Ingredients": FoodAttributeName.INGREDIENTS,
    "WWEIA Category description": FoodAttributeName.WWEIA_CATEGORY_DESCRIPTION,
    "WWEIA Category number": FoodAttributeName.WWEIA_CATEGORY_NUMBER
});

enum FoodAttributeTypeName {
    ADDITIONAL_DESCRIPTION,
    ADJUSTMENTS,
    ATTRIBUTE,
    UPDATE_LOG
}

final foodAttributeTypeNameValues = EnumValues({
    "Additional Description": FoodAttributeTypeName.ADDITIONAL_DESCRIPTION,
    "Adjustments": FoodAttributeTypeName.ADJUSTMENTS,
    "Attribute": FoodAttributeTypeName.ATTRIBUTE,
    "Update Log": FoodAttributeTypeName.UPDATE_LOG
});

enum FoodCategory {
    CHEESE,
    CHEESE_SANDWICHES,
    DAIRY_AND_EGG_PRODUCTS,
    SAUSAGES_AND_LUNCHEON_MEATS
}

final foodCategoryValues = EnumValues({
    "Cheese": FoodCategory.CHEESE,
    "Cheese sandwiches": FoodCategory.CHEESE_SANDWICHES,
    "Dairy and Egg Products": FoodCategory.DAIRY_AND_EGG_PRODUCTS,
    "Sausages and Luncheon Meats": FoodCategory.SAUSAGES_AND_LUNCHEON_MEATS
});

class FoodMeasure {
    String disseminationText;
    double gramWeight;
    int id;
    String modifier;
    int rank;
    MeasureUnit measureUnitAbbreviation;
    MeasureUnit measureUnitName;
    int measureUnitId;

    FoodMeasure({
        required this.disseminationText,
        required this.gramWeight,
        required this.id,
        required this.modifier,
        required this.rank,
        required this.measureUnitAbbreviation,
        required this.measureUnitName,
        required this.measureUnitId,
    });

    factory FoodMeasure.fromJson(Map<String, dynamic> json) => FoodMeasure(
        disseminationText: json["disseminationText"],
        gramWeight: json["gramWeight"]?.toDouble(),
        id: json["id"],
        modifier: json["modifier"],
        rank: json["rank"],
        measureUnitAbbreviation: measureUnitValues.map[json["measureUnitAbbreviation"]]!,
        measureUnitName: measureUnitValues.map[json["measureUnitName"]]!,
        measureUnitId: json["measureUnitId"],
    );

    Map<String, dynamic> toJson() => {
        "disseminationText": disseminationText,
        "gramWeight": gramWeight,
        "id": id,
        "modifier": modifier,
        "rank": rank,
        "measureUnitAbbreviation": measureUnitValues.reverse[measureUnitAbbreviation],
        "measureUnitName": measureUnitValues.reverse[measureUnitName],
        "measureUnitId": measureUnitId,
    };
}

enum MeasureUnit {
    UNDETERMINED
}

final measureUnitValues = EnumValues({
    "undetermined": MeasureUnit.UNDETERMINED
});

class FoodNutrient {
    int nutrientId;
    String nutrientName;
    String nutrientNumber;
    UnitName unitName;
    DerivationCode? derivationCode;
    String? derivationDescription;
    int? derivationId;
    double value;
    int? foodNutrientSourceId;
    String? foodNutrientSourceCode;
    FoodNutrientSourceDescription? foodNutrientSourceDescription;
    int rank;
    int indentLevel;
    int foodNutrientId;
    int? percentDailyValue;
    int? dataPoints;
    double? min;
    double? max;
    double? median;

    FoodNutrient({
        required this.nutrientId,
        required this.nutrientName,
        required this.nutrientNumber,
        required this.unitName,
        this.derivationCode,
        this.derivationDescription,
        this.derivationId,
        required this.value,
        this.foodNutrientSourceId,
        this.foodNutrientSourceCode,
        this.foodNutrientSourceDescription,
        required this.rank,
        required this.indentLevel,
        required this.foodNutrientId,
        this.percentDailyValue,
        this.dataPoints,
        this.min,
        this.max,
        this.median,
    });

    factory FoodNutrient.fromJson(Map<String, dynamic> json) => FoodNutrient(
        nutrientId: json["nutrientId"],
        nutrientName: json["nutrientName"],
        nutrientNumber: json["nutrientNumber"],
        unitName: unitNameValues.map[json["unitName"]]!,
        derivationCode: derivationCodeValues.map[json["derivationCode"]]!,
        derivationDescription: json["derivationDescription"],
        derivationId: json["derivationId"],
        value: json["value"]?.toDouble(),
        foodNutrientSourceId: json["foodNutrientSourceId"],
        foodNutrientSourceCode: json["foodNutrientSourceCode"],
        foodNutrientSourceDescription: foodNutrientSourceDescriptionValues.map[json["foodNutrientSourceDescription"]]!,
        rank: json["rank"],
        indentLevel: json["indentLevel"],
        foodNutrientId: json["foodNutrientId"],
        percentDailyValue: json["percentDailyValue"],
        dataPoints: json["dataPoints"],
        min: json["min"]?.toDouble(),
        max: json["max"]?.toDouble(),
        median: json["median"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "nutrientId": nutrientId,
        "nutrientName": nutrientName,
        "nutrientNumber": nutrientNumber,
        "unitName": unitNameValues.reverse[unitName],
        "derivationCode": derivationCodeValues.reverse[derivationCode],
        "derivationDescription": derivationDescription,
        "derivationId": derivationId,
        "value": value,
        "foodNutrientSourceId": foodNutrientSourceId,
        "foodNutrientSourceCode": foodNutrientSourceCode,
        "foodNutrientSourceDescription": foodNutrientSourceDescriptionValues.reverse[foodNutrientSourceDescription],
        "rank": rank,
        "indentLevel": indentLevel,
        "foodNutrientId": foodNutrientId,
        "percentDailyValue": percentDailyValue,
        "dataPoints": dataPoints,
        "min": min,
        "max": max,
        "median": median,
    };
}

enum DerivationCode {
    A,
    AS,
    BFFN,
    BFNN,
    BFZN,
    CAZN,
    LC,
    LCCD,
    LCCS,
    LCSL,
    MC,
    NC,
    NR,
    T,
    Z
}

final derivationCodeValues = EnumValues({
    "A": DerivationCode.A,
    "AS": DerivationCode.AS,
    "BFFN": DerivationCode.BFFN,
    "BFNN": DerivationCode.BFNN,
    "BFZN": DerivationCode.BFZN,
    "CAZN": DerivationCode.CAZN,
    "LC": DerivationCode.LC,
    "LCCD": DerivationCode.LCCD,
    "LCCS": DerivationCode.LCCS,
    "LCSL": DerivationCode.LCSL,
    "MC": DerivationCode.MC,
    "NC": DerivationCode.NC,
    "NR": DerivationCode.NR,
    "T": DerivationCode.T,
    "Z": DerivationCode.Z
});

enum FoodNutrientSourceDescription {
    ANALYTICAL_OR_DERIVED_FROM_ANALYTICAL,
    ASSUMED_ZERO,
    CALCULATED_BY_MANUFACTURER_NOT_ADJUSTED_OR_ROUNDED_FOR_NLEA,
    CALCULATED_FROM_NUTRIENT_LABEL_BY_NDL,
    CALCULATED_OR_IMPUTED,
    MANUFACTURER_S_ANALYTICAL_PARTIAL_DOCUMENTATION
}

final foodNutrientSourceDescriptionValues = EnumValues({
    "Analytical or derived from analytical": FoodNutrientSourceDescription.ANALYTICAL_OR_DERIVED_FROM_ANALYTICAL,
    "Assumed zero": FoodNutrientSourceDescription.ASSUMED_ZERO,
    "Calculated by manufacturer, not adjusted or rounded for NLEA": FoodNutrientSourceDescription.CALCULATED_BY_MANUFACTURER_NOT_ADJUSTED_OR_ROUNDED_FOR_NLEA,
    "Calculated from nutrient label by NDL": FoodNutrientSourceDescription.CALCULATED_FROM_NUTRIENT_LABEL_BY_NDL,
    "Calculated or imputed": FoodNutrientSourceDescription.CALCULATED_OR_IMPUTED,
    "Manufacturer's analytical; partial documentation": FoodNutrientSourceDescription.MANUFACTURER_S_ANALYTICAL_PARTIAL_DOCUMENTATION
});

enum UnitName {
    G,
    IU,
    KCAL,
    K_J,
    MG,
    UG
}

final unitNameValues = EnumValues({
    "G": UnitName.G,
    "IU": UnitName.IU,
    "KCAL": UnitName.KCAL,
    "kJ": UnitName.K_J,
    "MG": UnitName.MG,
    "UG": UnitName.UG
});

enum HouseholdServingFullText {
    EMPTY,
    THE_025_CUP,
    THE_075_ONZ,
    THE_1_ONZ,
    THE_1_SLICE_21_G
}

final householdServingFullTextValues = EnumValues({
    "": HouseholdServingFullText.EMPTY,
    "0.25 cup": HouseholdServingFullText.THE_025_CUP,
    "0.75 ONZ": HouseholdServingFullText.THE_075_ONZ,
    "1 ONZ": HouseholdServingFullText.THE_1_ONZ,
    "1 slice (21g)": HouseholdServingFullText.THE_1_SLICE_21_G
});

enum MarketCountry {
    UNITED_STATES
}

final marketCountryValues = EnumValues({
    "United States": MarketCountry.UNITED_STATES
});

enum ServingSizeUnit {
    G,
    GRM
}

final servingSizeUnitValues = EnumValues({
    "g": ServingSizeUnit.G,
    "GRM": ServingSizeUnit.GRM
});

enum TradeChannel {
    NO_TRADE_CHANNEL
}

final tradeChannelValues = EnumValues({
    "NO_TRADE_CHANNEL": TradeChannel.NO_TRADE_CHANNEL
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
