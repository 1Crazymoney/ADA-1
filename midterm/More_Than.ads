generic
   type Index is (<>);
   type Grid  is array (Index range <>, Index range <>) of Natural;

   function More_Than (G: Grid; Max: Natural) return Boolean;
