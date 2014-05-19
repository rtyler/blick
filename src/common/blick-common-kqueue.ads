--- Blick.Common.Kqueue is system interface wrapper around kqueue/kevent
--
--- Prototypes from the kevent(2) manpage
---     int
---     kqueue(void);
---
---     int
---     kevent(int kq, const struct kevent *changelist, int nchanges,
---         struct kevent *eventlist, int nevents,
---         const struct timespec *timeout);
---
---     EV_SET(&kev, ident, filter, flags, fflags, data, udata);
---

with Interfaces.C;
with Interfaces.C.Strings;
with System;

package Blick.Common.KQueue is

   -- Type for the kqueue file descriptor
   type Queue is new Integer;

   -- Ident_Type is a uintptr_t which is an unsigned int the size of a pointer
   -- on the system
   type Ident_Type is new Integer
      with Size => Standard'Address_Size;

   -- Type for `struct kevent`
   --  struct kevent {
   --          uintptr_t ident;        /* identifier for this event */
   --          short     filter;       /* filter for event */
   --          u_short   flags;        /* action flags for kqueue */
   --          u_int     fflags;       /* filter flag value */
   --          intptr_t  data;         /* filter data value */
   --          void      *udata;       /* opaque user data identifier */
   --  };
   type Event is record
      Ident        : Ident_Type;
      Filter       : Interfaces.C.Short;
      Flags        : Interfaces.C.Unsigned_Short;
      Filter_Flags : Interfaces.C.Unsigned; 
      Data         : System.Address;
      User_Data    : System.Address;
   end record;

   type Event_Ptr is access all Event
      with Convention => C;

   errno : Integer
      with Import, Convention => C;

   function StrError (E : in Integer) return Interfaces.C.Strings.Chars_Ptr
      with Import, Convention => C, Link_Name => "strerror";

   function Create return Queue
      with Import, Convention => C, Link_Name => "kqueue";

   function kevent (Q : in Queue;
                    Change_List : Event_Ptr;
                    Num_Changes : Integer;
                    Event_List : Event_Ptr;
                    Num_Events : Integer;
                    Timeout : System.Address) return Integer
      with Import, Convention => C, Link_Name => "kevent";

   function Listen (Q : in Queue;
                    Ev : Event_Ptr;
                    Num_Changes : in Integer) return Integer;

   function Receive (Q : in Queue;
                     Ev : Event_Ptr;
                     Num_Events : in Integer) return Integer;

--#define EV_ADD		0x0001		/* add event to kq (implies enable) */
--#define EV_DELETE	0x0002		/* delete event from kq */
--#define EV_ENABLE	0x0004		/* enable event */
--#define EV_DISABLE	0x0008		/* disable event (not reported) */

   EV_ADD : constant := 16#0001#;

--#define EVFILT_READ     (-1)
--#define EVFILT_WRITE        (-2)
--#define EVFILT_AIO      (-3)    /* attached to aio requests */
--#define EVFILT_VNODE        (-4)    /* attached to vnodes */
--#define EVFILT_PROC     (-5)    /* attached to struct proc */
--#define EVFILT_SIGNAL       (-6)    /* attached to struct proc */
--#define EVFILT_TIMER        (-7)    /* timers */
--#define EVFILT_PROCDESC     (-8)    /* attached to process descriptors */
--#define EVFILT_FS       (-9)    /* filesystem events */
--#define EVFILT_LIO      (-10)   /* attached to lio requests */
--#define EVFILT_USER     (-11)   /* User events */
--#define EVFILT_SENDFILE     (-12)   /* attached to sendfile requests */
--#define EVFILT_SYSCOUNT     12

   EVFILT_PROC : constant := -5;


--#define	NOTE_EXIT	0x80000000		/* process exited */
--#define	NOTE_FORK	0x40000000		/* process forked */
--#define	NOTE_EXEC	0x20000000		/* process exec'd */
--#define	NOTE_TRACK	0x00000001		/* follow across forks */

   NOTE_EXIT : constant := 16#80000000#;
   NOTE_FORK : constant := 16#40000000#;
   NOTE_EXEC : constant := 16#20000000#;
   NOTE_TRACK : constant := 16#00000001#;

end Blick.Common.KQueue;
