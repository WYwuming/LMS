function REMSE = myREMSE(x, y, Len)
    Tmp = sum((x-y).^2);
    REMSE = sqrt(Tmp/Len);
end