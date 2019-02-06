
with Ada.Text_IO;
use Ada.Text_IO;
procedure Mark2 is

   protected Printer is
      procedure Print(S: in String);
   end Printer;

   protected body Printer is
      procedure Print(S: in String) is
         begin
         Put_Line(S);
      end Print;
   end Printer;

   task Door is
      entry Open;
      entry Close;
   end Door;

   task body Door is
      isOpen : Boolean := False;
      begin
      loop
         select
            when not isOpen =>
               accept Open do
                  isOpen := True;
                  Printer.Print("Door is opened");
               end Open;
         or
            when isOpen =>
               accept Close do
                  isOpen := False;
                  Printer.Print("Door is closed");
               end Close;
         or
              terminate;
         end select;
      end loop;
   end Door;

   task Burglar;
   task body Burglar is
   begin
      delay  1.0;
      Door.Open;
      delay 3.0;
      Door.Close;
      end Burglar;

begin
   --  Insert code here.
   null;
end Mark2;
