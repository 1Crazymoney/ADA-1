generic
      type Elem is private;
package BagGen is


      type Bag (Max: Positive) is limited private;

      procedure Add( B: in out Bag; E: in Elem );
      procedure Remove( B: in out Bag; E: Elem );
      function Multiplicity(  B: Bag ; E: Elem ) return Natural;
      generic
      with procedure Process_Elem( B:Bag; Item: in Elem );
      procedure For_Each( B: in Bag);

private
      type Pair is record
		      Element: Elem;
		      Multiplicity: Natural := 0;
		   end record;
      type TArray is array( Integer range <> ) of Pair;
      type Bag(Max: Positive ) is record
                                    Data: TArray(1..Max);
                                    Pointer: Positive := 1;
                              end record;
end BagGen;
