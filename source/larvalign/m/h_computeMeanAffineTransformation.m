function [eul, trn] = h_computeMeanAffineTransformation(aff, b_first, ...
    eul, trn)
% computes average affine transformation matrix out of all the fed
% matrices.

%% input:
% aff : affine transformation matrix.
% b_first : boolean variable that tells concatentaion for the first
% incoming affine matrix shouldn't be done.
% b_doIt : boolean varialbe that tells all the affine matrices have
% arrived and the operation can be performed.
if b_first
    rot = aff(1:2, 1:2); % the first 2x2 matrix.
    rot = [rot; [0 0]];  % 3x2 matrix
    rot = [rot [0;0;1]]; % 3x3 matrix
    eul = rotm2eul(rot);

    trn = aff(1:2, 3);   % the last column.
else
    local_rot = aff(1:2, 1:2);
    local_rot = [local_rot; [0 0]];  % 3x2 matrix
    local_rot = [local_rot [0;0;1]]; % 3x3 matrix
    local_eul = rotm2eul(local_rot);

    local_trn = aff(1:2, 3);

    eul = cat(3, eul, local_eul);
    trn = cat(3, trn, local_trn);
end
end