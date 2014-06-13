
with AUnit.Test_Suites;

package body Blick.Tests.Statsd is

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite := new AUnit.Test_Suites.Test_Suite;
      T : access Statsd_Test := new Statsd_Test;
   begin
      Result.Add_Test (T);
      return Result;
   end Suite;

   procedure Register_Tests (T: in out Statsd_Test) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_To_Character'Access, "To_Character");
   end Register_Tests;

   function Name (T : in Statsd_Test) return AUnit.Message_String is
   begin
      return AUnit.Format ("Blick.Statsd Tests");
   end Name;

   procedure Test_To_Character (T : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      null;
   end Test_To_Character;

end Blick.Tests.Statsd;
