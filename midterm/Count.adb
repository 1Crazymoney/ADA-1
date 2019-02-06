function Count(G: Grid) return Natural is
   S: Natural := 0;
begin
   for i in G'Range(1) loop
      for j in G'Range(2) loop
         S:= S + G(i,j);
      end loop;
   end loop;
   return S;
end Count;
