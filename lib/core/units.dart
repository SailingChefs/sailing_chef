enum UnitGroup { weight, volume, count }

const kUnitPlaceholder = '---';

// Ordered list for dropdowns. kUnitPlaceholder is a UI sentinel that must not
// be stored or passed to the conversion service.
const kAllUnits = <String>[
  kUnitPlaceholder,
  // Weight — metric
  'g',
  'kg',
  // Weight — imperial
  'oz',
  'lb',
  // Volume — metric
  'ml',
  'l',
  // Volume — shared (tsp/tbsp are the same across both systems in cooking)
  'tsp',
  'tbsp',
  // Volume — imperial
  'cup',
  'fl oz',
  // Count — never converts
  'piece',
  'clove',
  'whole',
  'pinch',
  'slice',
  'can',
  'packet',
];

// Derive measurement type from a unit string. Units absent from this map
// (including kUnitPlaceholder) are treated as count (no conversion).
// tsp/tbsp are mapped to count because they are shared across both systems.
const kUnitGroups = <String, UnitGroup>{
  'g': UnitGroup.weight,
  'kg': UnitGroup.weight,
  'oz': UnitGroup.weight,
  'lb': UnitGroup.weight,
  'ml': UnitGroup.volume,
  'l': UnitGroup.volume,
  'cup': UnitGroup.volume,
  'fl oz': UnitGroup.volume,
  'tsp': UnitGroup.count,
  'tbsp': UnitGroup.count,
  'piece': UnitGroup.count,
  'clove': UnitGroup.count,
  'whole': UnitGroup.count,
  'pinch': UnitGroup.count,
  'slice': UnitGroup.count,
  'can': UnitGroup.count,
  'packet': UnitGroup.count,
};
