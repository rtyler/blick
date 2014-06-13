
with AUnit.Test_Suites;
with Blick.Tests.Statsd;

package body Blick.Tests is
   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite := new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (Blick.Tests.Statsd.Suite);
      return Result;
   end Suite;
end Blick.Tests;
