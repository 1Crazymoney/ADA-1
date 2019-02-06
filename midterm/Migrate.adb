procedure Migrate(G:in out Grid; Max: Natural) is
   Extra : Natural := 0;
   Add : Natural := 0;
begin
   for i in G'Range(1) loop
      for j in G'Range(2) loop
         if G(i,j) > Max then
            Extra := G(i,j) - Max;
            G(i,j) := Max;

            --up
            if  i /= G'First(1) then
               if G(Index'Pred(i),j) < Max then
                  Add := Max - G(Index'Pred(i),j);



                  if Extra > Add then

                     G(Index'Pred(i),j) := G(Index'Pred(i),j) + Add;
                     Extra := Extra - Add;
                  else

                     G(Index'Pred(i),j) := G(Index'Pred(i),j) + Extra;
                     Extra := Extra - Extra;
                  end if;


               end if;
            end if;

            --left
            if Extra > 0 and then j /= G'First(2) then
               if G(i,Index'Pred(j)) < Max then
                  Add := Max - G(i,Index'Pred(j));



                  if Extra > Add then

                     G(i,Index'Pred(j)) := G(i,Index'Pred(j)) + Add;
                     Extra := Extra - Add;
                  else

                     G(i,Index'Pred(j)) :=G(i,Index'Pred(j)) + Extra;
                      Extra := Extra - Extra;
                  end if;

               end if;

            end if;

            --right
            if Extra > 0 and then j /= G'Last(2) then
               if G(i,Index'Succ(j)) < Max then
                 Add := Max - G(i,Index'Succ(j));



                  if Extra > Add then

                     G(i,Index'Succ(j)) := G(i,Index'Succ(j)) + Add;
                      Extra := Extra - Add;
                  else

                     G(i,Index'Succ(j)) :=G(i,Index'Succ(j)) + Extra;
                     Extra := Extra - Extra;
                  end if;

               end if;
            end if;

            --down
            if Extra > 0 and then i /= G'Last(1) then
               if G(Index'Succ(i),j) < Max then
                  Add := Max -  G(Index'Succ(i),j);



                  if Extra > Add then

                     G(Index'Succ(i),j) :=  G(Index'Succ(i),j) + Add;
                      Extra := Extra - Add;
                  else

                     G(Index'Succ(i),j) :=  G(Index'Succ(i),j) + Extra;
                      Extra := Extra - Extra;
                  end if;

               end if;
            end if;



         end if;
      end loop;
   end loop;
end Migrate ;
