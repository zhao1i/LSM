function  interAng = do_interAngle(K_L, K_R)

interAng = nan;

if ~isnan(K_R)
    ang01 = atan(K_L) * (180/pi);
    ang02 = atan(K_R) * (180/pi);
    interAng = abs(ang01 - ang02);
end

end