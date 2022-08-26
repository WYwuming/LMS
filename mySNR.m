function snr = mySNR(x, y)
    Tmpx = sum(x.^2);
    Tmpy = sum((x-y).^2);
    snr = 10 * log10(Tmpx / Tmpy);
end