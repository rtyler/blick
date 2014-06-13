
with AUnit,
     AUnit.Test_Cases,
     AUnit.Test_Suites;

package Blick.Tests.Statsd is
   type Statsd_Test is new AUnit.Test_Cases.Test_Case with null record;

   procedure Register_Tests (T: in out Statsd_Test);
   function Name (T : in Statsd_Test) return AUnit.Message_String;
   procedure Test_To_Character (T : in out AUnit.Test_Cases.Test_Case'Class);

   function Suite return AUnit.Test_Suites.Access_Test_Suite;
end Blick.Tests.Statsd;
