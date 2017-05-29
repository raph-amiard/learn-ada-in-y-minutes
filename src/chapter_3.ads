--  Packages are Ada's module system. They allow you to regroup entities in
--  namespaces.

--  To get visibility on an entity defined in another file, you need the
--  "use-clause". Here we say that we want visibility on entities defined in
--  the Chapter_2 package.

with Chapter_2;

--  If a package is at the top level, it is called a 'library-item'. It is the
--  most common type of package
package Chapter_3 is

   --  You can define packages inside of other packages. This is useful for
   --  namespacing of entities.
   package Nested is
      I : Integer := 12;
   end Nested;

   --  You can already access what is defined into the Nested package.

   J : Integer := Nested.I;

   --  You can make everything defined into a package visible directly in the
   --  current scope, with a 'use clause'.

   use Nested;

   K : Integer := I;

   --  It will work with packages defined in the current file, but also with
   --  packages visible via a with clause.

   use Chapter_2;

   --  Div_Safe comes from the Chapter_2 package
   L : Integer := Div_Safe (J, K);

end Chapter_3;
