function Hd = filtroStopBandML(Fs)
%FILTROSTOPBANDML Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.4 and Signal Processing Toolbox 8.0.
% Butterworth Bandstop filter designed using FDESIGN.BANDSTOP.
% All frequency values are in Hz.

Fpass1 = 58;          % First Passband Frequency
Fstop1 = 59;          % First Stopband Frequency
Fstop2 = 60;          % Second Stopband Frequency
Fpass2 = 61;          % Second Passband Frequency
Apass1 = 0.5;         % First Passband Ripple (dB)
Astop  = 60;          % Stopband Attenuation (dB)
Apass2 = 1;           % Second Passband Ripple (dB)
match  = 'stopband';  % Band to match exactly

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.bandstop(Fpass1, Fstop1, Fstop2, Fpass2, Apass1, Astop, ...
                      Apass2, Fs);
Hd = design(h, 'butter', 'MatchExactly', match);