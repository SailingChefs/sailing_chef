import 'package:fraction/fraction.dart';
import 'package:sailing_chefs/core/units.dart';

class UnitConversionService {
  // Convert a stored quantity/unit pair for display using the viewer's
  // preference ('metric' or 'imperial'). Returns the original strings
  // unchanged when: unit is count/shared, the unit already matches the
  // preference, or the quantity cannot be parsed.
  static ({String quantity, String unit}) convertForDisplay(
    String quantityStr,
    String unit,
    String targetPreference,
  ) {
    final group = kUnitGroups[unit];
    if (group == null || group == UnitGroup.count) {
      return (quantity: quantityStr, unit: unit);
    }

    final qty = _parseQty(quantityStr);
    if (qty == null) return (quantity: quantityStr, unit: unit);

    return group == UnitGroup.weight
        ? _convertWeight(quantityStr, qty, unit, targetPreference)
        : _convertVolume(quantityStr, qty, unit, targetPreference);
  }

  // ── Weight ─────────────────────────────────────────────────────────────

  static const _metricWeight = {'g', 'kg'};
  static const _imperialWeight = {'oz', 'lb'};

  static ({String quantity, String unit}) _convertWeight(
      String raw, num qty, String unit, String pref) {
    if (pref == 'metric' && _metricWeight.contains(unit)) {
      return (quantity: raw, unit: unit);
    }
    if (pref == 'imperial' && _imperialWeight.contains(unit)) {
      return (quantity: raw, unit: unit);
    }

    final grams = _toGrams(qty, unit);
    if (pref == 'metric') {
      if (grams >= 1000) {
        return (quantity: _trimFixed(grams / 1000, 2), unit: 'kg');
      }
      return (quantity: grams.round().toString(), unit: 'g');
    } else {
      final oz = grams * 0.035274;
      if (oz >= 16) {
        return (quantity: _trimFixed(grams / 453.592, 2), unit: 'lb');
      }
      return (quantity: _trimFixed(oz, 1), unit: 'oz');
    }
  }

  static num _toGrams(num qty, String unit) => switch (unit) {
        'g' => qty,
        'kg' => qty * 1000,
        'oz' => qty * 28.3495,
        'lb' => qty * 453.592,
        _ => qty,
      };

  // ── Volume ─────────────────────────────────────────────────────────────

  static const _metricVolume = {'ml', 'l'};
  static const _imperialVolume = {'cup', 'fl oz'};

  static ({String quantity, String unit}) _convertVolume(
      String raw, num qty, String unit, String pref) {
    if (pref == 'metric' && _metricVolume.contains(unit)) {
      return (quantity: raw, unit: unit);
    }
    if (pref == 'imperial' && _imperialVolume.contains(unit)) {
      return (quantity: raw, unit: unit);
    }

    final ml = _toMl(qty, unit);
    if (pref == 'metric') {
      if (ml >= 1000) {
        return (quantity: _trimFixed(ml / 1000, 2), unit: 'l');
      }
      return (quantity: ml.round().toString(), unit: 'ml');
    } else {
      final flOz = ml / 29.5735;
      if (flOz >= 8) {
        return (quantity: _roundToCupFraction(ml / 236.588), unit: 'cup');
      }
      return (quantity: _trimFixed(flOz, 1), unit: 'fl oz');
    }
  }

  static num _toMl(num qty, String unit) => switch (unit) {
        'ml' => qty,
        'l' => qty * 1000,
        'cup' => qty * 236.588,
        'fl oz' => qty * 29.5735,
        _ => qty,
      };

  // ── Helpers ────────────────────────────────────────────────────────────

  static num? _parseQty(String s) {
    if (s.contains('/')) {
      try {
        return Fraction.fromString(s).toDouble();
      } catch (_) {
        return null;
      }
    }
    return num.tryParse(s);
  }

  // Round a cup quantity to the nearest common kitchen fraction
  // (¼, ⅓, ½, ⅔, ¾, or whole). Outputs Unicode fraction characters so
  // the result reads as "2½" rather than "2.5".
  static String _roundToCupFraction(double cups) {
    final whole = cups.floor();
    final frac = cups - whole;

    const fracValues = [0.0, 1 / 4, 1 / 3, 1 / 2, 2 / 3, 3 / 4, 1.0];
    const fracLabels = ['', '¼', '⅓', '½', '⅔', '¾', ''];

    var nearestIdx = 0;
    var nearestDiff = (fracValues[0] - frac).abs();
    for (var i = 1; i < fracValues.length; i++) {
      final diff = (fracValues[i] - frac).abs();
      if (diff < nearestDiff) {
        nearestDiff = diff;
        nearestIdx = i;
      }
    }

    final roundsToOne = nearestIdx == fracValues.length - 1;
    final w = roundsToOne ? whole + 1 : whole;
    final label = roundsToOne ? '' : fracLabels[nearestIdx];

    if (w == 0) return label.isEmpty ? '0' : label;
    return label.isEmpty ? '$w' : '$w$label';
  }

  // Round to `places` decimal places and strip a trailing ".0".
  static String _trimFixed(double value, int places) {
    final rounded = double.parse(value.toStringAsFixed(places));
    return rounded == rounded.roundToDouble()
        ? rounded.toInt().toString()
        : rounded.toString();
  }
}
