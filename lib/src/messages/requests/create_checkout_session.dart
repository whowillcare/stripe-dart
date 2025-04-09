part of '../../../messages.dart';

enum SessionMode {
  /// Accept one-time payments for cards, iDEAL, and more.
  payment,

  /// Save payment details to charge your customers later.
  setup,

  /// Use Stripe Billing to set up fixed-price subscriptions.
  subscription,
}

enum BillingAddressCollection {
  /// (Default) Checkout will only collect the billing address when necessary.
  auto,

  /// Checkout will always collect the customer’s billing address.
  required,
}

/// https://stripe.com/docs/api/checkout/sessions/create
@JsonSerializable()
class CreateCheckoutSessionRequest {
  /// The URL to which Stripe should send customers when payment or setup is
  /// complete. If you’d like access to the Checkout Session for the successful
  /// payment, read more about it in the guide on fulfilling orders.
  final String successUrl;

  /// The URL the customer will be directed to if they decide to cancel payment
  /// and return to your website.
  final String cancelUrl;

  /// The mode of the Checkout Session. Required when using prices or setup
  /// mode. Pass subscription if the Checkout Session includes at least one
  /// recurring item.
  final SessionMode? mode;

  /// A list of the types of payment methods (e.g., card) this Checkout Session
  /// can accept.
  ///
  /// Read more about the supported payment methods and their requirements in
  /// our payment method details guide.
  ///
  /// If multiple payment methods are passed, Checkout will dynamically reorder
  /// them to prioritize the most relevant payment methods based on the
  /// customer’s location and other characteristics.
  final List<PaymentMethodType> paymentMethodTypes;

  /// A unique string to reference the Checkout Session. This can be a customer
  /// ID, a cart ID, or similar, and can be used to reconcile the Session with
  /// your internal systems.
  final String? clientReferenceId;

  /// If provided, this value will be used when the Customer object is created.
  /// If not provided, customers will be asked to enter their email address. Use
  /// this parameter to prefill customer data if you already have an email on
  /// file. To access information about the customer once a session is complete,
  /// use the customer field.
  final String? customerEmail;

  /// ID of an existing customer, if one exists. The email stored on the
  /// customer will be used to prefill the email field on the Checkout page. If
  /// the customer changes their email on the Checkout page, the Customer object
  /// will be updated with the new email. If blank for Checkout Sessions in
  /// payment or subscription mode, Checkout will create a new customer object
  /// based on information provided during the payment flow.
  final String? customer;

  /// A list of items the customer is purchasing. Use this parameter to pass
  /// one-time or recurring Prices. One-time Prices in subscription mode will be
  /// on the initial invoice only.
  ///
  /// There is a maximum of 100 line items, however it is recommended to
  /// consolidate line items if there are more than a few dozen.
  final List<LineItem>? lineItems;

  /// Specify whether Checkout should collect the customer’s billing address.
  final BillingAddressCollection? billingAddressCollection;

  /// Settings for automatic tax lookup for this session and resulting payments,
  /// invoices, and subscriptions.
  final AutomaticTax? automaticTax;

  /// Controls tax ID collection settings for the session.
  final TaxIdCollection? taxIdCollection;

  /// A subset of parameters to be passed to PaymentIntent creation for Checkout
  /// Sessions in payment mode.
  final PaymentIntentData? paymentIntentData;

  /// A subset of parameters to be passed to subscription creation for Checkout
  /// Sessions in subscription mode.
  final SubscriptionData? subscriptionData;

  /// metadata
  /// nullable dictionary
  /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
  final Map<String, String>? metadata;

  CreateCheckoutSessionRequest({
    required this.successUrl,
    required this.cancelUrl,
    required this.paymentMethodTypes,
    this.mode,
    this.clientReferenceId,
    this.customerEmail,
    this.customer,
    this.lineItems,
    this.billingAddressCollection,
    this.automaticTax,
    this.taxIdCollection,
    this.paymentIntentData,
    this.subscriptionData,
    this.metadata,
  });

  factory CreateCheckoutSessionRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateCheckoutSessionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateCheckoutSessionRequestToJson(this);
}

@JsonSerializable()
class LineItem {
  final List<String>? images;

  /// The quantity of the line item being purchased. Quantity should not be
  /// defined when recurring.usage_type=metered.
  final int? quantity;

  final String? description;

  /// Data used to generate a new Price object inline. One of price or
  /// price_data is required.
  final PriceData? priceData;

  /// The ID of the Price or Plan object. One of price, price_data or amount is
  /// required.
  final String? price;

  LineItem({
    this.images,
    this.quantity,
    this.description,
    this.price,
    this.priceData,
  });

  factory LineItem.fromJson(Map<String, dynamic> json) =>
      _$LineItemFromJson(json);
  Map<String, dynamic> toJson() => _$LineItemToJson(this);
}

@JsonSerializable()
class PriceData {
  /// Three-letter ISO currency code, in lowercase. Must be a supported
  /// currency.
  final String currency;

  /// The ID of the product that this price will belong to. One of product or
  /// product_data is required.
  final String? product;

  /// A non-negative integer in cents representing how much to charge. One of
  /// unit_amount or unit_amount_decimal is required.
  final int? unitAmount;

  /// Data used to generate a new product object inline. One of product or
  /// product_data is required.
  final ProductData? productData;

  PriceData({
    required this.currency,
    this.product,
    this.unitAmount,
    this.productData,
  });

  factory PriceData.fromJson(Map<String, dynamic> json) =>
      _$PriceDataFromJson(json);
  Map<String, dynamic> toJson() => _$PriceDataToJson(this);
}

@JsonSerializable()
class ProductData {
  /// The product’s name, meant to be displayable to the customer. Whenever this
  /// product is sold via a subscription, name will show up on associated
  /// invoice line item descriptions.
  final String name;

  /// The product’s description, meant to be displayable to the customer. Use
  /// this field to optionally store a long form explanation of the product
  /// being sold for your own rendering purposes.
  final String? description;

  /// A list of up to 8 URLs of images for this product, meant to be displayable
  /// to the customer.
  final List<String>? images;

  ProductData({
    required this.name,
    this.description,
    this.images,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) =>
      _$ProductDataFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDataToJson(this);
}

@JsonSerializable()
class AutomaticTax {
  final bool enabled;

  AutomaticTax({
    required this.enabled,
  });

  factory AutomaticTax.fromJson(Map<String, dynamic> json) =>
      _$AutomaticTaxFromJson(json);
  Map<String, dynamic> toJson() => _$AutomaticTaxToJson(this);
}

@JsonSerializable()
class TaxIdCollection {
  final bool enabled;

  TaxIdCollection({
    required this.enabled,
  });

  factory TaxIdCollection.fromJson(Map<String, dynamic> json) =>
      _$TaxIdCollectionFromJson(json);
  Map<String, dynamic> toJson() => _$TaxIdCollectionToJson(this);
}

enum SetupFutureUsage {
  /// Use on_session if you intend to only reuse the payment method when your
  /// customer is present in your checkout flow.
  // ignore: constant_identifier_names
  on_session,

  /// Use off_session if your customer may or may not be present in your
  /// checkout flow.
  // ignore: constant_identifier_names
  off_session,
}

@JsonSerializable()
class PaymentIntentData {
  final String? receiptEmail;
  final SetupFutureUsage? setupFutureUsage;

  PaymentIntentData({
    this.receiptEmail,
    this.setupFutureUsage,
  });

  factory PaymentIntentData.fromJson(Map<String, dynamic> json) =>
      _$PaymentIntentDataFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentIntentDataToJson(this);
}

@JsonSerializable()
class SubscriptionData {
  /// Unix timestamp representing the end of the trial period the customer will
  /// get before being charged for the first time. Has to be at least 48 hours
  /// in the future.
  final int? trialEnd;

  /// Integer representing the number of trial period days before the customer
  /// is charged for the first time. Has to be at least 1.
  final int? trialPeriodDays;

  /// Set of key-value pairs that you can attach to an object. This can be
  /// useful for storing additional information about the object in a structured
  /// format. Individual keys can be unset by posting an empty value to them.
  /// All keys can be unset by posting an empty value to metadata.
  final Map<String, dynamic>? metadata;

  SubscriptionData({
    this.trialEnd,
    this.trialPeriodDays,
    this.metadata,
  });

  factory SubscriptionData.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionDataFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionDataToJson(this);
}
