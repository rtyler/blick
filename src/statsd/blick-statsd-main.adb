with Ada.Text_IO;
with Ada.Strings.Unbounded;

with Ada.Streams;

with Anet.Streams;
with Anet.Sockets.Inet;
with Anet.Receivers.Stream;
with Anet.Receivers.Datagram;

procedure Blick.Statsd.Main is
   use Ada.Text_IO;

   package Unbound renames Ada.Strings.Unbounded;

   package UDP_Receiver is new Anet.Receivers.Datagram
      (Socket_Type  => Anet.Sockets.Inet.UDPv4_Socket_Type,
       Address_Type => Anet.Sockets.Inet.UDPv4_Sockaddr_Type,
       Receive     => Anet.Sockets.Inet.Receive);

   procedure Process_Datagram (Item : Ada.Streams.Stream_Element_Array;
                               Src  : Anet.Sockets.Inet.UDPv4_Sockaddr_Type) is
      Buffer : Unbound.Unbounded_String;

      function To_Character (Byte : in Ada.Streams.Stream_Element) return Character is
      begin
         return Character'Val (Byte);
      end To_Character;

      use Ada.Streams;
   begin
      Put_Line ("Process_Datagram");
      for Byte : Ada.Streams.Stream_Element of Item loop
         -- Skip the new lines
         if Byte /= 16#a# then
            Unbound.Append (Buffer, To_Character (Byte));
         end if;
      end loop;
      Put_Line ("Buffer => " & Unbound.To_String (Buffer));
      Put_Line ("Exit Process_Datagram");
   end Process_Datagram;

   Socket   : aliased Anet.Sockets.Inet.UDPv4_Socket_Type;
   Receiver : UDP_Receiver.Receiver_Type (S => Socket'Access);
begin
   Put_Line ("Starting Blick Statsd relay");

   Socket.Init;
   Socket.Bind (Port => 9053);
   Receiver.Listen (Callback => Process_Datagram'Access);
end Blick.Statsd.Main;
