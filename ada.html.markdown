---
language: Ada
filename: learnada.adb
contributors:
    - ["Raphael Amiard", ""]
    - ["Fabien Chouteau", "https://twitter.com/DesChips"]
---
```ada

--  There's only single-line commants in Ada, they start with two consecutive
--  hyphens.

--  Let's start with a simple Hello World!

--  We are going to use the standard Ada.Text_IO package. We will learn more
--  about package with/use latter.
with Ada.Text_IO;

procedure Chapter_0 is
   --  The entry point of an Ada program can be a procedure with any name
begin

   --  Calling the Put_Line procedure of the Ada.Text_IO package to print on
   --  consol standard output.
   Ada.Text_IO.Put_Line ("Hello World!");
end Chapter_0;


procedure Chapter_1 is

   ----------------
   --  Variables --
   ----------------

   --  Declare a variable using <name> : <type>;
   X : Integer;
   --  Initialize a variable using <name> : <type> := <value>;
   Y : Integer := 0;
   --  Declare a constant variable using <name> : constant <type> := <value>;
   Z : constant Integer := 0;
   --  You can declare/initialize multiple variables of the same type
   A, B : Integer := 0;
   --  Numeric constant using <name> : constant := <value>;
   --  Numeric constants have infinite precision.
   Pi : constant := 3.14159_26535_89793_23846_26433_83279_50288_41971_69399;

   --------------------
   -- Standard types --
   --------------------

   Int  : constant Integer := -1;

   --  Natural is a subtype of Integer. We'll see what it means exactly later.
   --  The range of naturals is 0 to Integer'Last
   Nat  : constant Natural := 0;

   --  Positive is a subtype of Integer too.
   Pos  : constant Positive := 1;

   F    : Float := 0.0;
   Bool : Boolean := True;
   Char : constant Character := 'c';
   Str  : constant String := "Hello"; -- An array of Character

   --  Modular types (Unsigned integers) defined in the Interfaces packages
   Byte : Interfaces.Unsigned_8 := 0;

begin

   ---------------
   --  Literals --
   ---------------

   X := 10_000;   --  Decimal
   X := 10e5;     --  Decimal with exposant
   F := 2_000.0;  --  Real
   F := 1.0E-12;  --  Real with exposant

   --  Any base from 2 to 16
   X := 16#CAFE#; --  Hexadecimal
   X := 8#127#; -- Octal
   X := 2#1101_1101_0001_1001#; -- Binary

   --  Numeric literals have infinite precision
   X := 10e20_001 / 10e20_000; --  X equals 10

   -----------------
   -- Expressions --
   -----------------

   --  Assignment
   Y := Z;

   --  Mathematics
   X := X + 1;
   X := X - 1;
   X := X * 1;
   X := X / 1;
   X := X**2; -- Exponentiation (power)

   --  Binary operations. Those operations only work on modular types.
   Byte := Byte or 2#1111_1111#;
   Byte := Byte and 2#1111_1111#;
   Byte := Byte xor 2#1111_1111#;
   Byte := Shift_Left (Byte, 2);
   Byte := Shift_Right (Byte, 2);

   --  Comparison
   Bool := A = 0;  -- Equal
   Bool := A /= 0; -- Not equal
   Bool := A < 0;
   Bool := A > 0;
   Bool := A <= 0;
   Bool := A >= 0;

   --  Range membership
   Bool := A in -10 .. 10;

   --  Set membership
   Bool := A in 1 | 4 | 8;

   --  Declare blocks allow introducing new declarations in a sequence of
   --  statements.
   declare
      --  String (and array) concatenation
      Str_2 : String := Str & " World!";
   begin
      --  Strings and arrays are immutable (cannot change their length), so
      --  this is illegal:
      --  Str_2 := Str_2 & "World !";

      --  Prints "Hello World!"
      Put_Line (Str_2);
   end;

   -------------------------
   --  Control structures --
   -------------------------

   if Y > 0 then
      X := -1;
   elsif A < 0 then -- Optional
      X := 1;
   else             -- Optional
      X := 0;
   end if;

   --  While loop
   while A < 10 loop
      A := A + 1;
   end loop;

   --  Break loops
   loop
      A := A - 1;
      exit when A = 0;
   end loop;

   --  Named loops
   First_Loop : loop
      Second_Loop : loop

         exit First_Loop;

      end loop Second_Loop;
   end loop First_Loop;

   --  For loop on a range
   for Index in 1 .. 10 loop
      A := A + 1;
   end loop;

   --  For loop on an array or container (a string is an array)
   for Char of Str loop
      A := A + 1;
   end loop;

   --  Case (switches)
   case B is
      when -9 =>      --  Single value
         A := 0;
      when -1 | -2 =>  --  Multiple values
         A := 1;
      when -3 .. -4 => --  Ranges
         A := 2;
      when -6 | -8 .. -10 => -- All combinable
         A := 2;
         X := 2;

      when Positive => -- Check for a whole subtype's range

         null; --  Do nothing...

      --  Case statement must cover all possible values. If we stop here, the
      --  compiler will give us an error like:
      --  chapter_1.adb:164:04: missing case values: -16#8000_0000# .. -10
      --  chapter_1.adb:164:04: missing case values: -8 .. -7
      --  chapter_1.adb:164:04: missing case values: -5 .. -3
      --  chapter_1.adb:164:04: missing case value: 0

      --  Use "when other" to cover all the remaining values
      when others =>
         null;
   end case;

   --  Goto? Yes, but it's not a reason to use it...
   goto Label;
   <<Label>>

   --  Conditional expresssion (parentheses are required)
   B := (if Bool then 0 else A);

   --  Case expressions: same as case statements (coverage checking)
   X := (case B is
            when 1 => 1,
            when 2 | 3 => 10,
            when others => 0);

   --  Quantified expressions

   --  Check that a predicate is true for all values of a container
   Bool := (for all Char of Str => Char /= 'e'); -- False

   --  Check that a predicate is true for at least one value of a container
   Bool := (for some Char of Str => Char = 'e'); -- True

end Chapter_1;
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
--  Packages are Ada's module system. They allow you to regroup entities in
--  namespaces.
package Chapter_3 is
   --  Packages
   --  With and use
end Chapter_3;
package body Chapter_3 is
   -- Subprogram bodies
end Chapter_3;
procedure Chapter_4 is
   -- Discrete types, enums, Arrays
   -- Strings, enums
   -- Real types
begin
   null;
end Chapter_4;
procedure Chapter_5 is
   --  Standard library (10 000 feets)
   --  Generics usage
   --  Generics implementation
   --  Containers
begin
   null;
end Chapter_5;
procedure Chapter_6 is
   -- Discriminated types
   -- Tagged types
   -- Privacy/encapsulation
   -- Child packages
begin
   null;
end Chapter_6;
procedure Chapter_7 is
   -- Access types
   -- Dynamic allocation
begin
   null;
end Chapter_7;
```
