part of '../../messages.dart';

enum PaymentMethodType {
  // ignore: constant_identifier_names
  acss_debit,
  affirm,
  // ignore: constant_identifier_names
  afterpay_clearpay,
  alipay,
  // ignore: constant_identifier_names
  amazon_pay,
  // ignore: constant_identifier_names
  au_becs_debit,
  // ignore: constant_identifier_names
  bacs_debit,
  bancontact,
  blik,
  boleto,
  card,
  interac_present,
  // ignore: constant_identifier_names
  card_present,
  cashapp,
  // ignore: constant_identifier_names
  customer_balance,
  eps,
  fpx,
  giropay,
  grabpay,
  ideal,
  klarna,
  konbini,
  link,
  oxxo,
  p24,
  paynow,
  pix,
  promptpay,
  // ignore: constant_identifier_names
  sepa_debit,
  sofort,
  // ignore: constant_identifier_names
  us_bank_account,
  // ignore: constant_identifier_names
  wechat_pay,
}

/// https://stripe.com/docs/api/checkout/sessions/object
@JsonSerializable()
class CheckoutSession extends Message {
  /// Doesn't work with enum because there is a dot in it.
  final String object;
  final String id;
  final String? clientReferenceId;
  final String? customer;
  final String? paymentIntent;
  final List<PaymentMethodType> paymentMethodTypes;
  final String? status;
  final String? url;
  final Map<String, String>? metadata;
  /// The Epoch time in seconds at which the Checkout Session will expire. It can be anywhere from 30 minutes to 24 hours after Checkout Session creation. By default, this value is 24 hours from creation.
  final int? expiresAt;

  CheckoutSession({
    required this.object,
    required this.id,
    required this.paymentMethodTypes,
    this.clientReferenceId,
    this.customer,
    this.paymentIntent,
    this.status,
    this.url,
    this.metadata,
    this.expiresAt
  });

  factory CheckoutSession.fromJson(Map<String, dynamic> json) =>
      _$CheckoutSessionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CheckoutSessionToJson(this);
}
