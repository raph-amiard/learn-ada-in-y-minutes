with Ada.Text_IO; use Ada.Text_IO;

procedure Chapter_2 is
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
      Put_Line ("Your name is " & My_Name);
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

   --  Functions have a short-hand, called expression functions. Please also
   --  note that when a subprogram has several parameters, they're separated by
   --  semicolons, not commas, in the declaration.
   function Mult (L : Integer; R : Integer) return Integer
   is (L * R);


   --  When you have several parameters of the same type, you can aggregate
   --  them as follows:
   function Div (L, R : Integer) return Integer
   is (L / R);

   --  There are different ways of passing parameters in Ada, called modes.
   --  So far we have been passing parameters with the "in" mode, which is
   --  the default.
   --
   --  You also have "out" parameters, which indicates a parameter that will be
   --  written to. An out parameter is akin to a value returned by a function.

   procedure Copy (Source : in Character; Dest : out Character) is
   begin
      Dest := Source;
   end Copy;

   --  The last mode is the "in-out" mode. It specifies that a parameter can be
   --  both read and written to. This is similar to passing a parameter by
   --  reference (In C you would use a pointer).

   procedure Increment (A : in out Integer) is
   begin
      A := A + 1;
   end Increment;

   --  Ada also has subprogram overloading: Subprograms can have the same name,
   --  but different parameters. The compiler will determine at compile time
   --  which subprogram should be called.

   procedure Increment (A : in out Integer; Step : Integer) is
   begin
      A := A + Step;
   end Increment;

   --  Ada also has return type overloading, a less common feature, so
   --  that the following code is valid.

   function Zero return Integer is (0);
   function Zero return Float is (0.0);

   --  Ada also has default values for parameters.

   procedure Decrement (A : in out Integer; Step : Integer := 1) is
   begin
      A := A - Step;
   end Decrement;

   --  Ada supports contracts, in the form of pre and post conditions.
   --  Post conditions specify the guarantees that your subprogram gives to the
   --  caller.

   procedure Incorrect_Swap (A, B : in out Integer)
     with Post => (B = A'Old and A = B'Old)
   is
   begin
      A := B;
      B := A;
   end Incorrect_Swap;
   --  Calling this will fail raising an assertion error at runtime.

   --  TODO: Add an example with a Pre

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
      A : Integer := 12;
      B : Integer := 15;
   begin
      Incorrect_Swap (A, B);
   end;

end Chapter_2;
