% png1.m  - a function for making jpegs from graph windows without using
% the file|export options|export... and another 20 mouseclicks to navigate
% to the right folder.

function png1(fn),

print('-dpng','-opengl',fn);

return;