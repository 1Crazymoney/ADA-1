with Migrate,Count_Value, Count, More_Than, Ada.Integer_Text_IO,Ada.Text_IO;

procedure Main is


   function moreThan3(N: Natural) return Boolean is
   begin
      if N > 3 then
         return True;
      end if;
      return False;
   end moreThan3;

   type TGrid is array (Positive range <>, Positive range <>) of Natural;
   function myCount is new Count(Positive,TGrid);
   function myMore_Than is new  More_Than(Positive,TGrid);
   function myCount_Value is new Count_Value(Natural,Positive,TGrid,moreThan3);
   procedure myMigrate is new Migrate(Positive,TGrid);

   procedure printM(G: TGrid) is
   begin
      for i in G'Range(1) loop
      for j in G'Range(2) loop
            Ada.Integer_Text_IO.Put(G(i,j));
            Ada.Text_IO.Put("   ");
         end loop;
         Ada.Text_IO.New_Line;
   end loop;
   end printM;




   M : TGrid(1..10,1..10) := (others => (others => 1));

begin

   --Ada.Integer_Text_IO.Put(myCount(M));
   --Ada.Text_IO.Put_Line(Boolean'Image(myMore_Than(M,109)));
  M(3,4) := 8;
   M(5,7) := 90;

   Ada.Integer_Text_IO.Put(myCount_Value(M));
   --printM(M);
   --Ada.Text_IO.New_Line;
   --myMigrate(M,3);
   --printM(M);





end Main;
