
with Ada.Streams;
with Ada.Strings.Unbounded;

with Alog.Logger;
with Alog.Facilities.File_Descriptor;

with Anet.Streams;
with Anet.Sockets.Inet;
with Anet.Receivers.Stream;
with Anet.Receivers.Datagram;

procedure Blick.Statsd.Main is
   use Alog;

   --  Initialize logger instance with default file descriptor facility
   --  (logs to stdout).
   Log : Logger.Instance (Init => True);

   package Unbound renames Ada.Strings.Unbounded;

   package UDP_Receiver is new Anet.Receivers.Datagram
      (Socket_Type  => Anet.Sockets.Inet.UDPv4_Socket_Type,
       Address_Type => Anet.Sockets.Inet.UDPv4_Sockaddr_Type,
       Receive     => Anet.Sockets.Inet.Receive);

   ---
   -- Simple utility funciton to turn a Ada.Streams.Stream_Element into a
   -- single Character
   ---
   function To_Character (Byte : in Ada.Streams.Stream_Element) return Character is
   begin
      return Character'Val (Byte);
   end To_Character;


   ---
   -- The compositor task is responsible for collecting metrics as they come in
   -- as raw datagrams and then flushing the results as they are composed
   -- together
   --
   -- This separate from the datagram receive code to ensure that we can handle
   -- metric data across datagram boundaries.
   ---
   task Compositor is
      entry Process_Datagram (Item : Ada.Streams.Stream_Element_Array);
   end Compositor;

   task body Compositor is
      Buffer : Unbound.Unbounded_String;

      use Ada.Streams;
   begin
      loop
         accept Process_Datagram (Item : Ada.Streams.Stream_Element_Array) do
            for Byte : Ada.Streams.Stream_Element of Item loop
               -- Skip the new lines
               if Byte /= 16#a# then
                  Unbound.Append (Buffer, To_Character (Byte));
               else
                  Log.Log_Message (Source => "Compositor",
                                   Level  => Info,
                                   Msg    => "`" & Unbound.To_String (Buffer) & "` composed; flushing");
                  -- XXX: Handle the metric
                  Unbound.Delete (Buffer, 1, Unbound.Length (Buffer));
               end if;
            end loop;
         end;
      end loop;
   end Compositor;

   ---
   -- Receive the datagram straight off the socket and then send it to the
   -- compositor. The compositor will handle parsing/processing the actual
   -- datagram itself
   ---
   procedure Receive_Datagram (Item : Ada.Streams.Stream_Element_Array;
                               Src  : Anet.Sockets.Inet.UDPv4_Sockaddr_Type) is
   begin
      Compositor.Process_Datagram (Item);
   end Receive_Datagram;

   Socket   : aliased Anet.Sockets.Inet.UDPv4_Socket_Type;
   Receiver : UDP_Receiver.Receiver_Type (S => Socket'Access);
begin
   --  Write a message with loglevel 'Info' to stdout.
   Log.Log_Message (Source => "Main",
                    Level  => Info,
                    Msg    => "Starting the Blick statsd relay");

   Socket.Init;
   Socket.Bind (Port => 8125);
   Receiver.Listen (Callback => Receive_Datagram'Access);
end Blick.Statsd.Main;
