with Ada.Text_IO; use Ada.Text_IO;

procedure Chapter_2 is
   --  Subprograms
   --  Subprograms 2: Parameters modes, default values, named
   --  parameters, pre/post

   --  Ada has two kinds of subprograms, or subroutines, or functions
   --  (depending on your native language)

   --  We already know procedures
   procedure Print_Hello_World is
   begin
      Put_Line ("Hello world !");
   end Print_Hello_World;

   --  They can have parameters
   procedure Say_My_Name (My_Name : String) is
   begin
      Put_Line ("My name " & My_Name);
   end Say_My_Name;

   --  Ada also has functions, that return a value
   function Return_2 return Integer is
   begin
      return 2;
   end Return_2;

   --  Functions and procedures can have parameters
   function Double (Num : Integer) return Integer is
   begin
      return Num * 2;
   end Double;

   --  Functions have a short-hand, called expression functions
   function Mult (L, R : Integer) return Integer
   is (L * R);

   A : Integer;
begin

   --  You can call a subprogram with no parameters by just typing its name
   Print_Hello_World;

   --  If the subprogram has parameters, put them in parens
   Say_My_Name ("Roger");

   --  When calling functions, you have to use the result of the function
   A := Return_2;

   --  Trying to call a function and ignoring its return value will result in a
   --  compiler error:
   --  Return_2;
   --  chapter_2.adb:xx:xx: cannot use function "Return_2" in a procedure call

   --  Of course you can use the value of a function in a call to another
   --  function
   A := Mult (Return_2, 15);

   declare

   begin
      null;
   end;

end Chapter_2;
