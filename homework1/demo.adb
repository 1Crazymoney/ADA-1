
with BagGen, Ada.Integer_Text_IO, Ada.Text_IO;

procedure Demo is

package IBag is new BagGen(Integer);

procedure Put_Pair( B:IBag.Bag; Item: Integer ) is
begin
      Ada.Integer_Text_IO.Put(Item);
      Ada.Integer_Text_IO.Put(IBag.Multiplicity(B,Item));
      Ada.Text_IO.New_Line;
end Put_Pair;

procedure Put_Bag is new IBag.For_Each(Put_Pair);

B: IBag.Bag(5);

begin
   --Add procedure illustration
   IBag.Add(B,66);
   IBag.Add(B,3);
   IBag.Add(B,1);
   IBag.Add(B,5);
   IBag.Add(B,7);
   IBag.Add(B,7);
   IBag.Add(B,7);
   --For_Each procedure illustration
   Put_Bag(B);

   Ada.Text_IO.New_Line;

   --Remove procedure illustration
   IBag.Remove(B,1);
   IBag.Remove(B,7);
   Put_Bag(B);

    Ada.Text_IO.New_Line;

   --Multiplicity function illustration
   Ada.Integer_Text_IO.Put(IBag.Multiplicity(B,3));


end Demo;
