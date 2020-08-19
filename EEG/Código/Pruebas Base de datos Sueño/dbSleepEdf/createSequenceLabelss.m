function [sequence_labels_train,sequence_labels_test] = createSequenceLabelss(Nseq,trainLabels,testLabels)
% 



%%
%
% Nseq = 16;
idxARR = strcmpi(trainLabels,'T0');
ARRtmp = repelem(trainLabels(idxARR),Nseq);
idxCHF = strcmpi(trainLabels,'T1');
CHFtmp = repelem(trainLabels(idxCHF),Nseq);
idxNSR = strcmpi(trainLabels,'T2');
NseqRtmp = repelem(trainLabels(idxNSR),Nseq);
idxt3 = strcmpi(trainLabels,'T3');
t3tmp = repelem(trainLabels(idxt3),Nseq);
idxt4 = strcmpi(trainLabels,'T4');
t4tmp = repelem(trainLabels(idxt4),Nseq);

sequence_labels_train = [ARRtmp; CHFtmp; NseqRtmp; t3tmp; t4tmp];
%%

idxARR = strcmpi(testLabels,'T0');
ARRtmp = repelem(testLabels(idxARR),Nseq);
idxCHF = strcmpi(testLabels,'T1');
CHFtmp = repelem(testLabels(idxCHF),Nseq);
idxNSR = strcmpi(testLabels,'T2');
NseqRtmp = repelem(testLabels(idxNSR),Nseq);
idxt3 = strcmpi(testLabels,'T3');
t3tmp = repelem(testLabels(idxt3),Nseq);
idxt4 = strcmpi(testLabels,'T4');
t4tmp = repelem(testLabels(idxt4),Nseq);

sequence_labels_test = [ARRtmp; CHFtmp; NseqRtmp; t3tmp; t4tmp];