%%
%% Image registration framework for registration of the larval CNS of Drosophila melanogaster
%%
%% Author: S.E.A. Muenzing
%% SEAM@2016-06-09
%%
function msg = larvalignMain(varargin)
% setdbprefs('errorhandling','report')

OutputDir = 'D:\Harsha\Files_Hiwi\Output';
path_sfx = 'D:\Harsha\01.Hiwi\Files_Hiwi\48h_APF\scaled_620x276\';
fm = '48hAPF_Brp_TH_nCad_brain1_nCad.tif';
LSM_PFN=[path_sfx fm];
varargin={'OutputDir', OutputDir, 'Method', 'FullyAutomatic', 'CPUGPU', 'CPU', 'LSM_PFN', LSM_PFN, 'LSMchannelNP', '3', 'LSMchannelNT', '2', 'LSMchannelGE', '1'};

warning('off','all');

%% Command line call
msg = MainIRF(varargin{:});


end
%%
%%
%%
