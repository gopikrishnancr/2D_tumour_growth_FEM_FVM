Two dimensional tumour growth model : br2d_main.m
-------------------------------------------------

The theoretical aspects of this matlab code can be found in the article 'Numerical solution of a two dimensional
tumour growth model with moving boundary'. A brief description of the files are parameters are given below. 

Files and functions 
-------------------
br2d_main.m   - main file.
red_mesh      - constructs the elements, coordinates, and other geometric aspects of the triangulation. 
                (see the file geom_readme.txt)
element_structure - create a structure that contains the area, centroid, vertices, face normals of the triangles.
assembly_matrices - constructs the local gradient and mass matrices for sparse assembly
assign_vfrac      - assign initial volume fraction depending on the initial domain
get_component     - construct the element and coordinates for the tumour domain at time t_n
vpth_opt          - Taylor Hood FEM for velocity and pressure
volume_frac       - Upwind FVM for the volume fraction equation
c_tension         - Lumped mass P1 FEM for the oxygen tension equation
plot_general      - plots as .pdf figures in the folder 'folder_plots'

Parameters 
----------

t_intial                        initial time
t_final                         final time
T_STEPS                         # of time steps
dt                              time step size
square_side                     half side length of the domain \Omega_\ell
mesh_index                      Type of structured triangulation
ref_index                       # of refinements
geom_type                       switch between structured and unstructured
g_index                         initial domain for the unstructured triangulation
a_thr                           threshold value; ideal between 0.001 and 0.02
