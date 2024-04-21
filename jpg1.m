% jpg1.m  - a function for making jpegs from graph windows without using
% the file|export options|export... and another 20 mouseclicks to navigate
% to the right folder.

function jpg1(fn),

fn2=sprintf('..\\..\\..\\MyReports\\LoadBankRecommendations\\%s',fn);
print('-djpeg',fn2);

return;