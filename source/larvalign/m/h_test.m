function h_test
tic
fprintf("before pause\n");
pause(10);
fprintf("after pause\n");
t = toc;
fprintf("time elapsed is %g\n", t);
end