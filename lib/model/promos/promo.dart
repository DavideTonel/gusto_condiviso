class Promo {
  final int id;
  final String name;
  final String endDate;
  final String description;
  final String useInstructions;
  final String companyId;

  Promo(
    {
      required this.id,
      required this.name,
      required this.endDate,
      required this.description,
      required this.useInstructions,
      required this.companyId
    }
  );
}