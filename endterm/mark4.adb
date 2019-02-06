with Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Numerics.Discrete_Random;
use Ada.Text_IO, Ada.Numerics.Float_Random;
procedure Mark4 is

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
   end Door;
   type PDoor is access Door;
   PD : PDoor;
   type APDoors is array (Index range <>) of PDoor;

   protected House is
      procedure Init;
      procedure Get_Door(OPDoor : out PDoor);
   private
      doors : APDoors(1..5);
   end House;


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
         Put_Line("Choosen door: " & Index'Image(Id));
      end Get_Door;

   end House;


   task body Burglar is
   begin
      delay  1.0;
      House.Get_Door(PD);
      PD.Open;
      select
         accept Hit do
         Printer.Print("Burglar got hit.");
         end Hit;
      or
         delay 3.0;
      end select;

      PD.Close;
   end Burglar;

begin
     Reset(RanDoorGen);
   House.Init;
end Mark4;
