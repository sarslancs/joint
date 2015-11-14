function [ cdata ] = read_cifti( filename, wb_command )
%READ_CIFTI Import dscalar.nii files into Matlab
%   CDATA = READ_CIFTI(FILENAME, WB_COMMAND) reads the file given as
%   FILENAME using the native wb_command program, the path of which is
%   given either as a string in WB_COMMAND or specified below as default.
% 
%   This function directly makes use of the native wb_command utility,
%   distributed as part of the HCP Workbench availabel at
%   http://www.humanconnectome.org/software/get-connectome-workbench.html
%   In order to use this function, the "wb_command" variable below should 
%   be set to the path the wb_command executable has been extracted to. 

if nargin == 1
    wb_command = '/vol/medic02/users/sa1013/Workbench/Workbench_Ver_1_Final/exe_linux64/wb_command';
    % Please set this to the path where "wb_command" exe has been extracted to. 
end

cii = ciftiopen(filename, wb_command);  
cdata = cii.cdata;

end

