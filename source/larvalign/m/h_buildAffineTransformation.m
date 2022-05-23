function mat = h_buildAffineTransformation(eul, trn)
eul = mean(eul, 3);
trn = mean(trn, 3);

rot_avg = eul2rotm(eul);
rot_avg = rot_avg(1:2, 1:2);

affine_col = [0 0 1];
mat = [rot_avg trn]; % mat will be (3x2) matrix.
mat = [mat; affine_col]; % mat will be (3x3) matrix.
end