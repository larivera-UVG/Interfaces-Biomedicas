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
sequence_labels_train = [ARRtmp; CHFtmp; NseqRtmp];
%%

idxARR = strcmpi(testLabels,'T0');
ARRtmp = repelem(testLabels(idxARR),Nseq);
idxCHF = strcmpi(testLabels,'T1');
CHFtmp = repelem(testLabels(idxCHF),Nseq);
idxNSR = strcmpi(testLabels,'T2');
NseqRtmp = repelem(testLabels(idxNSR),Nseq);
sequence_labels_test = [ARRtmp; CHFtmp; NseqRtmp];