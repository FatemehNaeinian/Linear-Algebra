SHORE_image = imread('Shore.jpg');
SHORE_image = rgb2gray(SHORE_image);
SHORE_image = imcrop(SHORE_image, [1, 70, 299, 299]);
figure
imshow(SHORE_image)
title('original picture')

SHORE_image = double(SHORE_image);

[U, S, V] = my_svd(SHORE_image);
figure
subplot(2, 4, 1)
imshow(uint8(U*S*V'))
title('300 values')
subplot(2, 4, 2)
S250 = selectSingularValues(S, 250);
imshow(uint8(U*S250*V'))
title('250 values')
subplot(2, 4, 3)
S200 = selectSingularValues(S, 200);
imshow(uint8(U*S200*V'))
title('200 values')
subplot(2, 4, 4)
S150 = selectSingularValues(S, 150);
imshow(uint8(U*S150*V'))
title('150 values')
subplot(2, 4, 5)
S100 = selectSingularValues(S, 100);
imshow(uint8(U*S100*V'))
title('100 values')
subplot(2, 4, 6)
S50 = selectSingularValues(S, 50);
imshow(uint8(U*S50*V'))
title('50 values')
subplot(2, 4, 7)
S25 = selectSingularValues(S, 25);
imshow(uint8(U*S25*V'))
title('25 values')
subplot(2, 4, 8)
S10 = selectSingularValues(S, 10);
imshow(uint8(U*S10*V'))
title('10 values')

figure
S90 = selectSingularValues(S, 90);
imshow(uint8(U*S90*V'))
title('90 values')


% Checked whether U and V are orthonormal, and SHORE = U*S*V':
% mean(abs(U*U' - eye(300)) <= 0.0001, 'all')
% mean(abs(V*V' - eye(300)) <= 0.0001, 'all')
% mean(abs(U*S*V' - SHORE) <= 0.1, 'all')
