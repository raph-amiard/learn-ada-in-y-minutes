--  Exclude from article
-----------
-- DRAFT --
-----------
--  End of exclusion

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

