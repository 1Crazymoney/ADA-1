generic
   type Index is (<>);
   type Grid  is array (Index range <>, Index range <>) of Natural;


   procedure Migrate(G:in out Grid; Max: Natural);
