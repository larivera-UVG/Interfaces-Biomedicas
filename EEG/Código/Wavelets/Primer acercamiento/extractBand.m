%Copyright 2017 The MathWorks, Inc.
function newBand = extractBand(ecgsig,level,stLevl,endLevel) %#codegen
wt = modwt(ecgsig,level);
wtrec = zeros(size(wt));
wtrec(stLevl:endLevel,:) = wt(stLevl:endLevel,:);
newBand = imodwt(wtrec,'sym4');

