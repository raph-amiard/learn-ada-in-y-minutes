-----------
-- DRAFT --
-----------

with Ada.Text_IO; use Ada.Text_IO;
with Interfaces;  use Interfaces;

procedure Chapter_1 is
   --  Basic Syntax
   --  Variable declarations
   --  Built-in types
   --  Expressions
   --  Control structures (if/loop)

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
   --  Named number using <name> : constant := <value>;
   Pi : constant := 3.14159_26535_89793_23846_26433_83279_50288_41971_69399;

   --------------------
   -- Standard types --
   --------------------

   Int  : constant Integer := -1;
   Nat  : constant Natural := 0;
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

   --  Infinite precision
   X := 10e20_001 / 10e20_000; --  X equals 10

   -----------------
   -- Expressions --
   -----------------

   --  Assignment
   Y := Z;

   --  Conditional expresssion (parentheses are required)
   B := (if Bool then 0 else A);
   X := (case B is
            when 1 => 1,
            when 2 => 10,
            when others => 0);

   --  Quantified expressions
   Bool := (for all Char of Str => Char /= 'e'); -- False
   Bool := (for some Char of Str => Char = 'e'); -- True

   ---------------
   -- Operators --
   ---------------

   --  Mathematics
   X := X + 1;
   X := X - 1;
   X := X * 1;
   X := X / 1;
   X := X**2; -- Exponentiation (power)

   --  Binary
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
      when 0 =>      --  Single value
         A := 0;
      when 1 | 2 =>  --  Multiple values
         A := 1;
      when 3 .. 4 => --  Ranges
         A := 2;
      when 6 | 8 .. 10 =>
         A := 2;
         X := 2;

      --  Case statement must cover all possible values. If we stop here, the
      --  compiler will give us an error like:
      --          XX:4 missing case values: -16#8000_0000# .. -1
      --          XX:4 missing case value: 5
      --          XX:4 missing case value: 7
      --          XX:4 missing case values: 11 .. 16#7FFF_FFFF#

      --  Use "when other" to cover all the remaining values
      when others =>
         null; --  Do nothing...
   end case;

   --  Goto? Yes, but it's not a reason to use it...
   goto Label;
   <<Label>>

end Chapter_1;
