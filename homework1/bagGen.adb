package body BagGen is

     function isEinData( Data : in TArray; E: Elem ; IndexE: out Integer ) return Boolean is
        begin
          for I in Data'Range loop
            if Data(I).Element = E then
                IndexE := I;
		return True;
            end if;
           end loop;
	   return False;
     end;

      procedure  Add( B: in out Bag; E: in Elem ) is
        IndexE: Integer;
      begin
         if isEinData(B.Data, E, IndexE) then
            B.Data(IndexE).Multiplicity :=  B.Data(IndexE).Multiplicity + 1;
         else
            if B.Pointer <= B.Max then
               B.Data(B.Pointer).Element := E;
               B.Data(B.Pointer).Multiplicity := 1;
               B.Pointer := B.Pointer + 1;
            end if;
         end if;
      end Add;

      procedure Remove( B: in out Bag; E: Elem ) is
      IndexE: Integer;
      begin
         if isEinData(B.Data, E, IndexE) then
            B.Data(IndexE).Multiplicity :=  B.Data(IndexE).Multiplicity - 1;
            if B.Data(IndexE).Multiplicity = 0 then
               if B.Pointer > 2 then
                  B.Data(IndexE).Element := B.Data(B.Pointer-1).Element;
                  B.Data(IndexE).Multiplicity :=  B.Data(B.Pointer-1).Multiplicity;
               end if;
               B.Pointer := B.Pointer - 1;
            end if;
         end if;
      end;

      function Multiplicity(  B: Bag ; E: Elem ) return Natural is
      IndexE: Integer;
      begin
      if isEinData(B.Data, E, IndexE) then
             return B.Data(IndexE).Multiplicity;
          end if;
          return 0;
      end;

   procedure For_Each( B: in Bag  ) is
      LastIndex: Integer := B.Data'First + B.Pointer - 2;
      begin
         for I in B.Data'First..LastIndex loop
            Process_Elem( B, B.Data(I).Element );
         end loop;
      end For_Each;

end BagGen;
