with Ada.Text_IO, Ada.Numerics.Float_Random,  Ada.Numerics.Discrete_Random;
use Ada.Text_IO;
procedure Main is

   N: Natural := 6;

   subtype DriverType is Integer range 1 .. 3;
   package Random_DriverType is new Ada.Numerics.Discrete_Random (DriverType);
   use Random_DriverType;

   RD : Random_DriverType.Generator;

   type pstr is access STRING;
   type pduration is access Duration;

   protected type petrolStation( Max: Positive := 5 ) is
      entry registerCar(licenceN : pstr);
      procedure finish(licenceN :in pstr);
   private
      ins: Natural := Max;
   end petrolStation;

   protected body petrolStation is
      entry registerCar(licenceN : pstr)  when ins > 0 is
      begin
         ins := ins - 1;
         put_line(licenceN.all & " is filling up. ");
      end registerCar;

      procedure finish(licenceN :in pstr) is begin
         put_line(licenceN.all & " has finished filling up. ");
         ins := ins + 1;
      end finish;
   end petrolStation;

      P : petrolStation(N);

   task type car(licenceN: pstr; fillingTime : pduration);
   type Car_Access is access car;
   task body car is

      driver : Integer := Random(RD);

      Gen : Ada.Numerics.Float_Random.Generator;
      Rnd : Float := Ada.Numerics.Float_Random.Random(Gen);
      arrivalTime : Float ;

      leave: Boolean := False;

      exitLoop: Boolean := False;
      I : Integer := 0;

   begin
      arrivalTime := 0.5 * Rnd + 0.1;

      delay Duration(arrivalTime);

      if driver = 1 then
         select
            P.registerCar(licenceN);
            delay fillingTime.all;
             P.finish(licenceN);
         else
            put_line(licenceN.all & ".Impatient driver.Leaved.");
         end select;
      elsif driver = 2 then
         select
            P.registerCar(licenceN);
            delay fillingTime.all;
             P.finish(licenceN);
         or
            delay 0.5; put_line(licenceN.all & ".Patient driver.Waited and Leaved.");
         end select;

      elsif driver = 3 then
         P.registerCar(licenceN);
         delay fillingTime.all;
         P.finish(licenceN);
      end if;

   end car;

   C: Car_Access;

begin
   Random_DriverType.Reset(RD);

   for I in 1..N+10 loop
      C := new car( new String'("Car-" & Integer'Image(I)), new Duration'(3.0));
   end loop;

end Main;
