function []=FuncaoE4()

global ARec;
global h1 yh1 NSAMPLES;
global h2 yh2;

myRec = getaudiodata(ARec);
if length(myRec) < NSAMPLES
    return;
end

yh1 = myRec(end-NSAMPLES+1:end);
refreshdata(h1, 'caller');

Y_fft = fft(yh1, NSAMPLES);
P2 = abs(Y_fft / NSAMPLES);
P1 = P2(1:NSAMPLES/2);
P1(2:end-1) = 2*P1(2:end-1);

max_P1 = max(P1);
if max_P1 > 0
    yh2 = P1 / max_P1;
else
    yh2 = P1;
end

refreshdata(h2, 'caller');

end