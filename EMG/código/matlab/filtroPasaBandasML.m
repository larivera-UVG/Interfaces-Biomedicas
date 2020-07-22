function Hd = filtroPasaBandasML(Fs,Lf,Hf)
%FILTROPASABANDASML Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.4 and Signal Processing Toolbox 8.0.
% Butterworth Bandpass filter designed using FDESIGN.BANDPASS.
% All frequency values are in Hz.

Fstop1 = Lf-10;       % First Stopband Frequency
Fpass1 = Lf;          % First Passband Frequency
Fpass2 = Hf-10;       % Second Passband Frequency
Fstop2 = Hf;          % Second Stopband Frequency
Astop1 = 60;          % First Stopband Attenuation (dB)
Apass  = 1;           % Passband Ripple (dB)
Astop2 = 80;          % Second Stopband Attenuation (dB)
match  = 'passband';  % Band to match exactly

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.bandpass(Fstop1, Fpass1, Fpass2, Fstop2, Astop1, Apass, ...
                      Astop2, Fs);
Hd = design(h, 'butter', 'MatchExactly', match);
