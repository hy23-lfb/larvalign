%%
%% Image registration framework for registration of the larval CNS of Drosophila melanogaster
%%
%% Author: S.E.A. Muenzing
%% SEAM@2016-06-09
%%
function msg = larvalignMain(varargin)
% setdbprefs('errorhandling','report')

warning('off','all');

OutputDir = 'D:\Harsha\Files_Hiwi\Output';

%LSM_PFN= 'I:\00.masterarbeit_dataset\03.Additional_Data_Larvalign\512x512_ch2\13E04_33E02_MB003B_020613B.lsm';
%findNPChannel = true;

LSM_PFN = varargin{1};
findNPChannel = varargin{2};

fprintf("[Harsha] Moving file: %s\n", LSM_PFN);
if (findNPChannel == false)
    varargin={'OutputDir', OutputDir, 'Method', 'FullyAutomatic', 'CPUGPU', 'CPU', 'LSM_PFN', LSM_PFN, 'LSMchannelNP', '3'};
else
    % read lsm channel info
    [~, scaninf, ~] = lsminfo(LSM_PFN);
    index = find([scaninf.WAVELENGTH{:}] == 633);
    tmp_a = [1,2,3];
    tmp_b = tmp_a(tmp_a~=index);

    LSMchannelNP = int2str(index);
    LSMchannelNT = int2str(tmp_b(1));
    LSMchannelGE = int2str(tmp_b(2));

    fprintf("[Harsha] NP Channel: %s\n", LSMchannelNP);

    varargin={'OutputDir', OutputDir, 'Method', 'FullyAutomatic', 'CPUGPU', 'CPU', 'LSM_PFN', LSM_PFN, 'LSMchannelNP', LSMchannelNP, 'LSMchannelNT', LSMchannelNT, 'LSMchannelGE', LSMchannelGE};
end

%% Command line call
msg = MainIRF(varargin{:});

%%
%%
%%
end