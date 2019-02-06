generic
   type Elem is private;
   type Index is (<>);
   type Grid  is array (Index range <>, Index range <>) of Elem;
   with function Predicate(E: Elem) return Boolean;

   function Count_Value (G: Grid) return Natural;
