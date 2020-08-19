function [trainData, testData, trainLabels, testLabels] = helperRandomSplits(percent_train_split,EEGData)
% This function is only in support of XpwWaveletMLExample. It may change or
% be removed in a future release.
    Labels = EEGData.Labels;
    Data = EEGData.Data;
    percent_train_split = percent_train_split/100;
    idxARRbegin = find(strcmpi(Labels,'T0'),1,'first');
    idxARRend = find(strcmpi(Labels,'T0'),1,'last');
    Narr = idxARRend-idxARRbegin+1;
    idxCHFbegin = find(strcmpi(Labels,'T1'),1,'first');
    idxCHFend = find(strcmpi(Labels,'T1'),1,'last');
    Nchf = idxCHFend-idxCHFbegin+1;
    idxNSRbegin = find(strcmpi(Labels,'T2'),1,'first');
    idxNSRend = find(strcmpi(Labels,'T2'),1,'last');
    Nnsr = idxNSRend-idxNSRbegin+1;
    idxt3begin = find(strcmpi(Labels,'T3'),1,'first');
    idxt3end = find(strcmpi(Labels,'T3'),1,'last');
    Nt3 = idxt3end-idxt3begin+1;
    idxt4begin = find(strcmpi(Labels,'T4'),1,'first');
    idxt4end = find(strcmpi(Labels,'T4'),1,'last');
    Nt4 = idxt4end-idxt4begin+1;
    
    % Obtain number needed for percentage split
    num_train_arr = round(percent_train_split*Narr);
    num_train_chf = round(percent_train_split*Nchf);
    num_train_nsr = round(percent_train_split*Nnsr);
    num_train_t3 = round(percent_train_split*Nt3);
    num_train_t4 = round(percent_train_split*Nt4);
    
    rng default;
    Parr = randperm(Narr,num_train_arr);
    Pchf = randperm(Nchf,num_train_chf);
    Pnsr = randperm(Nnsr,num_train_nsr);
    Pt3 = randperm(Nt3,num_train_t3);
    Pt4 = randperm(Nt4,num_train_t4);
    
    notParr = setdiff(1:Narr,Parr);
    notPchf = setdiff(1:Nchf,Pchf);
    notPnsr = setdiff(1:Nnsr,Pnsr);
    notPt3 = setdiff(1:Nt3,Pt3);
    notPt4 = setdiff(1:Nt4,Pt4);
    
    
    ARRdata = Data(idxARRbegin:idxARRend,:);
    ARRLabels = Labels(idxARRbegin:idxARRend);
    CHFdata = Data(idxCHFbegin:idxCHFend,:);
    CHFLabels = Labels(idxCHFbegin:idxCHFend);
    NSRdata = Data(idxNSRbegin:idxNSRend,:);
    NSRLabels = Labels(idxNSRbegin:idxNSRend);
    t3data = Data(idxt3begin:idxt3end,:);
    t3Labels = Labels(idxt3begin:idxt3end);
    t4data = Data(idxt4begin:idxt4end,:);
    t4Labels = Labels(idxt4begin:idxt4end);
    
    trainARR = ARRdata(Parr,:);
    trainARRLabels = ARRLabels(Parr);
    testARR = ARRdata(notParr,:);
    testARRLabels = ARRLabels(notParr);
    trainCHF = CHFdata(Pchf,:);
    trainCHFLabels = CHFLabels(Pchf);
    testCHF = CHFdata(notPchf,:);
    testCHFLabels = CHFLabels(notPchf);
    trainNSR = NSRdata(Pnsr,:);
    trainNSRLabels = NSRLabels(Pnsr);
    testNSR = NSRdata(notPnsr,:);
    testNSRLabels = NSRLabels(notPnsr);
    traint3 = t3data(Pt3,:);
    traint3Labels = t3Labels(Pt3);
    testt3 = t3data(notPt3,:);
    testt3Labels = t3Labels(notPt3);
    traint4 = t4data(Pt4,:);
    traint4Labels = t4Labels(Pt4);
    testt4 = t4data(notPt4,:);
    testt4Labels = t4Labels(notPt4);
    
    trainData = [trainARR ; trainCHF; trainNSR; traint3; traint4];
    trainLabels = [trainARRLabels ; trainCHFLabels; trainNSRLabels; traint3Labels; traint4Labels];
    testData = [testARR ; testCHF; testNSR; testt3; testt4];
    testLabels = [testARRLabels; testCHFLabels; testNSRLabels; testt3Labels; testt4Labels];
   
    