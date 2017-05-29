-- Packages can also have "child packages". They are, like nested packages,
-- nested inside their parent package (here Chapter 3), except that they are at
-- the top level. This allows you to put them in different files.
package Chapter_3.Child_Package is

   --  Everything defined in Chapter_3 is directly visible from here.

   M : Integer := L;

end Chapter_3.Child_Package;
