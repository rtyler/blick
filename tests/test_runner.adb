with AUnit.Reporter.Text;
with AUnit.Run;

with Blick.Tests;

procedure Test_Runner is
   procedure Runner is new AUnit.Run.Test_Runner (Blick.Tests.Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   Runner (Reporter);
end Test_Runner;
