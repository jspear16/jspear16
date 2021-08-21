clc
A1 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment3 Code\test1.dat");
A2 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment3 Code\test2.dat");
A3 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment3 Code\test3.dat");
A4 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment3 Code\test4.dat");
A5 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment3 Code\test5.dat");
A6 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment3 Code\test6.dat");
A7 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment3 Code\test7.dat");
A8 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment3 Code\test8.dat");
A9 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment3 Code\test9.dat");
A10 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment3 Code\test10.dat");
A11 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment3 Code\test11.dat");
A12 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment3 Code\test12.dat");
A13 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment3 Code\test13.dat");
A14 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment3 Code\test14.dat");
A15 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment3 Code\test15.dat");
A16 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment3 Code\test16.dat");
A17 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment3 Code\test17.dat");
A18 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment3 Code\test18.dat");
A19 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment3 Code\test19.dat");
A20 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment3 Code\test20.dat");
AF = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment3 Code\final.dat");
AH = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment3 Code\half.dat");
AT = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment3 Code\test500.dat");


B = reshape(AF(:,2),[16,16])

hold off
surf(B)
hold on
xlabel('X-Axis')
ylabel('Y-Axis')
title('Initial Conditions of the Transverse Wave')
ax = gca;
ax.FontSize = 17;
