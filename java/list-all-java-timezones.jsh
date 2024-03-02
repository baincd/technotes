import java.time.*;
import java.util.*;
import java.util.function.Function;

System.out.println(ZonedDateTime.now());
System.out.println(java.text.MessageFormat.format("{0} {1} ({2})", System.getProperty("java.vm.vendor"), System.getProperty("java.vm.version"), System.getProperty("java.version.date")));

final ZoneId UTC = ZoneId.of("UTC");

var now = Instant.now();
var equinox1 = LocalDate.of(now.atZone(UTC).getYear(),06,20).atStartOfDay(UTC).toInstant();
var equinox2 = LocalDate.of(now.atZone(UTC).getYear(),12,21).atStartOfDay(UTC).toInstant();
Comparator<? super ZoneId> zoneIdCompartor = (z1,z2) -> {
  int offsetCompare = z2.getRules().getStandardOffset(now).getTotalSeconds() - z1.getRules().getStandardOffset(now).getTotalSeconds();
  if (offsetCompare != 0) {
    return offsetCompare;
  } else if (z1.getId().contains("/") && !z2.getId().contains("/")) {
    return 1;
  } else if (!z1.getId().contains("/") && z2.getId().contains("/")) {
    return -1;
  } else {
    return z1.getId().compareTo(z2.getId());
  }
};

Function <ZoneId, String> zoneIdDetailedString = zoneId -> {
  var stdOffset = zoneId.getRules().getStandardOffset(now);
  var eq1Offset = zoneId.getRules().getOffset(equinox1);
  var eq2Offset = zoneId.getRules().getOffset(equinox2);

  var retn = "(" + stdOffset;
  if (!eq1Offset.equals(stdOffset)) {
    retn += "/" + eq1Offset;
  }
  if (!eq2Offset.equals(stdOffset) && !eq2Offset.equals(eq1Offset)) {
    retn += "/" + eq2Offset;
  }

  retn += ")";
  retn = retn.replaceAll("Z","+00:00");
  while (retn.length() < 17) {
    retn += " ";
  }
  return retn + zoneId.getId();
}

ZoneId.getAvailableZoneIds().stream().map(ZoneId::of).sorted(zoneIdCompartor).map(zoneIdDetailedString).forEach(System.out::println);

/exit
