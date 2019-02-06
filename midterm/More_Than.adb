function More_Than (G: Grid; Max: Natural) return Boolean is
   S: Natural := 0;
begin
   for i in G'Range(1) loop
      for j in G'Range(2) loop
         S:= S + G(i,j);
         if S > Max then
            return True;
            end if;
      end loop;
   end loop;
   return False;
end More_Than;
