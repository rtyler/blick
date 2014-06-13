private with Interfaces.C;
private with System;
private with System.Address_Image;

package body Blick.Common.KQueue is
   use Interfaces.C;

   function Listen (Q : in Queue;
                    Ev : Event_Ptr;
                    Num_Changes : in Integer) return Integer is
   begin
      return kevent (Q, Ev, Num_Changes, null, 0, System.Null_Address);
   end Listen;

   function Receive (Q : in Queue;
                     Ev : Event_Ptr;
                     Num_Events : in Integer) return Integer is
   begin
      return kevent (Q, null, 0, Ev, 1, System.Null_Address);
   end Receive;

end Blick.Common.KQueue;
