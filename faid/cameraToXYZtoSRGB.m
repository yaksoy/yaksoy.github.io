function image = cameraToXYZtoSRGB(image, colorMatrix, calibrationIlluminant)
    % RGBcolor = XYZ2RGB(inv(ColorMatrix) * RAW)
    XYZtoCamera = reshape(colorMatrix, [3 3])';
    imf = reshape(image, [size(image, 1) * size(image, 2), 3])';
    imf = XYZtoCamera \ imf;
    imf = reshape(imf', [size(image, 1), size(image, 2), 3]);
    image = xyz2rgb(imf, 'WhitePoint', illuminantCode(calibrationIlluminant));
end

function code = illuminantCode(CalibrationIlluminant)
    % Returns 'WhitePoint' parameter for MATLAB's xyz2rgb
    if CalibrationIlluminant == 17
        code = 'a';
        return
    elseif CalibrationIlluminant == 19
        code = 'c';
        return
    elseif CalibrationIlluminant == 20
        code = 'd55';
        return
    elseif CalibrationIlluminant == 21
        code = 'd65';
        return
    elseif CalibrationIlluminant == 23
        code = 'd50';
        return
    else
        code = [];
        return
    end
end

% http://www.awaresystems.be/imaging/tiff/tifftags/privateifd/exif/lightsource.html
% 0 = Unknown
% 1 = Daylight
% 2 = Fluorescent
% 3 = Tungsten (incandescent light)
% 4 = Flash
% 9 = Fine weather
% 10 = Cloudy weather
% 11 = Shade
% 12 = Daylight fluorescent (D 5700 - 7100K)
% 13 = Day white fluorescent (N 4600 - 5400K)
% 14 = Cool white fluorescent (W 3900 - 4500K)
% 15 = White fluorescent (WW 3200 - 3700K)
% 17 = Standard light A
% 18 = Standard light B
% 19 = Standard light C
% 20 = D55
% 21 = D65
% 22 = D75
% 23 = D50
% 24 = ISO studio tungsten
% 255 = Other light source