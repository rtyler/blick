with Ada.Finalization;

package Blick.Listener is

   type Listener_Type is interface;

   procedure Initialize (L : in Listener_Type) is abstract;

   -- XXX: Implement Finalization

   function Name (L : in Listener_Type) return String is abstract;

   function Is_Runnable (L : in Listener_Type) return Boolean is abstract;

   procedure Start (L : in Listener_Type) is abstract;
   procedure Stop (L : in Listener_Type) is abstract;

end Blick.Listener;
