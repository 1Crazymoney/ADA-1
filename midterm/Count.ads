generic
   type Index is (<>);
   type Grid  is array (Index range <>, Index range <>) of Natural;

   function Count(G: Grid) return Natural;
