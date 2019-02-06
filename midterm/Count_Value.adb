function Count_Value (G: Grid) return Natural is
   S: Natural := 0;
begin
   for i in G'Range(1) loop
      for j in G'Range(2) loop
         if Predicate(G(i,j)) then
             S:= S + 1;
            end if;
      end loop;
   end loop;
   return S;
end Count_Value;
