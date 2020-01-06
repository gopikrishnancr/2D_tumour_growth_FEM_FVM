Description of the spatial geometry and discretisation
------------------------------------------------------

There are two types of geometries and triangulations that can be handled by this code.

1. Structured triangulation on a square with side length '2a' with circular shaped initial domain. 

	
2. Unstructured triangulation
    a) Circular shaped initial domain
	b) Cross shaped initial domain
	c) Bullet shaped initial domain
	d) Semi annular shaped domain
	e) irregular shaped initial domain
	
% Please request to gopikrishnan.chirappurathuremesan@monash.edu if you need other data files.
	
	
For 1, the parameter setting is as follows:

   square_side  = 5;    % side length of the extended domain 
   mesh_index   = 1;    % Geometry for structured triangulation, can be from 1 to 7.
   ref_index    = 5;    % Refinement index for structured triangulation.
   geom_mesh = 0;  	
   g_index  = 1;        % NEVER CHANGE THIS HERE.
   
For 2, the parameter setting is as follows:

   square_side  = 5;    % side length of the extended domain 
   mesh_index   = 1;    % always 1 in this case: NEVER CHANGE THIS.
   ref_index    = 1;    % always 1 in this case: NEVER CHANGE THIS.
   geom_mesh = 1;  	
   g_index  = 1;        % 1 - circular, 2 - cross shaped, 3 - bullet shaped, 
                        % 4 - semi-annular, 5 - irregular

  