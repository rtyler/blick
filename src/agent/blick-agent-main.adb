
with Ada.Command_Line;
with Ada.Text_IO;
with Interfaces.C;
with Interfaces.C.Strings;
with System;

with ZMQ.Sockets;
with ZMQ.Contexts;
with ZMQ.Messages;

with Blick.Common.KQueue;
with Blick.Listener;

procedure Blick.Agent.Main is
   use Ada.Text_IO;
   ctx              : ZMQ.Contexts.Context;
   s                : ZMQ.Sockets.Socket;
   q                : Blick.Common.KQueue.Queue := Blick.Common.KQueue.Create;
   pid              : Integer;

   procedure Watch_Process (Pid : in Integer) is
      Event : Blick.Common.KQueue.Event_Ptr :=  new Blick.Common.KQueue.Event;
      Result : Integer;

      use Interfaces.C;
      use Blick.Common.KQueue;
   begin
      Put_Line ("We'll be watching PID:" & Pid'Img);
      Event.Ident := Ident_Type (Pid);
      Event.Filter := EVFILT_PROC;
      Event.Flags := EV_ADD;
      Event.Filter_Flags := NOTE_EXIT or NOTE_FORK or NOTE_EXEC or NOTE_TRACK;

      Result := Blick.Common.KQueue.Listen (q, Event, 1);

      if Result = -1 then
         Put_Line ("Errno:" & Integer'Image (errno));
         Put_Line (Interfaces.C.Strings.Value (StrError (Errno)));
      end if;

      Put_Line ("Listen returned:" & Result'Img);
   end Watch_Process;

   procedure Wait is
      Event : Blick.Common.KQueue.Event_Ptr :=  new Blick.Common.KQueue.Event;
      Result : Integer;
      use Interfaces.C;
      use Blick.Common.KQueue;
   begin
      Put_Line ("waiting");

      --loop
         Result :=  Blick.Common.KQueue.Receive (q, Event, 1);
         Put_Line ("Waiting returned:" & Result'Img);

         if (Event.Filter_Flags and NOTE_EXEC) = 0 then
            Put_Line ("Exec'd!");
         end if;
      --end loop;
   end Wait;
begin
   if Ada.Command_Line.Argument_Count /= 2 then
      Put_Line (Ada.Command_Line.Command_Name & " takes <hostname:port> <pid>");
      Ada.Command_Line.Set_Exit_Status (1);
      return;
   end if;

   pid := Integer'Value (Ada.Command_Line.Argument (2));

   Watch_Process (pid);

   Wait;

   --  Initialise 0MQ context, requesting a single application thread
   --  and a single I/O thread
   ctx.Set_number_of_IO_threads (1);

   --   Create a ZMQ_REP socket to receive requests and send replies
   s.Initialize (ctx, ZMQ.Sockets.REQ);

   --   Bind to the TCP transport and port 5555 on the 'lo' interface
   s.Connect ("tcp://" & Ada.Command_Line.Argument (1));

   for i in  1 .. 10 loop
      declare
         query_string : constant String := "SELECT * FROM mytable";
         query        : ZMQ.Messages.Message;
      begin
         query.Initialize (query_string & "(" & i'Img & " );");
         s.Send (query);
      end;

      declare
         resultset        : ZMQ.Messages.Message;
      begin
         resultset.Initialize;
         s.Recv (resultset);
         Put_Line ('"' & resultset.GetData & '"');
      end;
   end loop;
end Blick.Agent.Main;
