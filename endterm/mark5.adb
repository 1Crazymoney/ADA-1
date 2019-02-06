with Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Numerics.Discrete_Random;
use Ada.Text_IO, Ada.Numerics.Float_Random;
procedure Mark5 is

   protected Safe_Random is
      entry Init;
      procedure Generate(Rnd: out Duration);
   private
      Initialised : Boolean := False;
      G : Generator;
   end Safe_Random;

   protected body Safe_Random is

      entry Init when not Initialised is
      begin
         Reset(G);
      end Init;

      procedure Generate(Rnd: out Duration) is
         RndD : Duration;
      begin
         RndD := Duration(Random(G) * 4.0);
      end Generate;


   end Safe_Random;

   protected Printer is
      procedure Print(S: in String);
   end Printer;

   protected body Printer is
      procedure Print(S: in String) is
      begin
         Put_Line(S);
      end Print;
   end Printer;

   task Burglar is
      entry Hit;
   end Burglar;


   task type Trap;
   task body Trap is
      RndD : Duration;
   begin
      Safe_Random.Init;
      Safe_Random.Generate(RndD);
      Printer.Print("Trap. Waiting for" & Duration'Image(RndD) & " seconds.");
      delay RndD;
      select
         Burglar.Hit;

      or
         delay 0.01;
      end select;
   end Trap;
   type PTrap is access Trap;
   PT : PTrap;

   subtype Index is  Integer range 1..5;
   package RanDoor is new Ada.Numerics.Discrete_Random(Index); use RanDoor;
   RanDoorGen : RanDoor.Generator;
   myID : Index := 2;
   task type Door(ID : Index) is
      entry Open;
      entry Close;
      entry Set_Trap;
   end Door;
   type PDoor is access Door;
   PD : PDoor;
   type APDoors is array (Index range <>) of PDoor;

   protected House is
      procedure Init;
      procedure Get_Door(OPDoor : out PDoor);
      procedure Get_Door(Door_ID: in Index;DoorAccess: out PDoor);
   private
      doors : APDoors(1..5);
   end House;

   task Kevin is
      entry Catch;
   end Kevin;
   task body Kevin is
   begin
      delay 0.5;
      for I in Index'Range loop
         House.Get_Door(I,PD);
         PD.Set_Trap;
         Printer.Print("Kevin setting trap on door " & Index'Image(I));
         select
            accept Catch  do
               Printer.Print("Kevin is catched by Burglar.");
            end Catch;
         or
            delay 1.0;
         end select;
      end loop;
         select
            accept Catch  do
               Printer.Print("Kevin is catched by Burglar.");
            end Catch;
         or
            terminate;
         end select;
   end Kevin;



   task body Door is
      isOpen : Boolean := False;
   begin
      loop
         select
            when not isOpen =>
               accept Open do
                  PT := new Trap;
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
            accept Set_Trap  do
               null;
            end Set_Trap;
         or

            terminate;
         end select;
      end loop;
   end Door;

   protected body House is
      procedure Init is
      begin
         for I in doors'Range loop
            doors(I) := new Door(I);
         end loop;
      end Init;

      procedure Get_Door(OPDoor : out PDoor) is
         Id: Index;
      begin

         Id := Random(RanDoorGen);
         OPDoor := doors(Id);
         Printer.Print("Choosen door: " & Index'Image(Id));
      end Get_Door;

      procedure Get_Door(Door_ID: in Index;DoorAccess: out PDoor) is
      begin
         DoorAccess := doors(Door_ID);
      end Get_Door;


   end House;


   task body Burglar is
   PD1: PDoor;
   begin
      delay  3.5;
      House.Get_Door(PD1);
      PD1.Open;
      select
         accept Hit do
            Printer.Print("Burglar got hit.");
         end Hit;
      or
         delay 3.0;
         Kevin.Catch;
      end select;
      PD1.Close;
   end Burglar;

begin
   Reset(RanDoorGen);
   House.Init;
end Mark5;
