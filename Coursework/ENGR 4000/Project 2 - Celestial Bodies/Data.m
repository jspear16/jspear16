clc
TKE = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment2 Code\TKE.dat");
TU = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment2 Code\TU.dat");
TLX = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment2 Code\TLX.dat");
TLY = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment2 Code\TLY.dat");
TLZ = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment2 Code\TLZ.dat");
Error1 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment2 Code\ErrorVsRuntime1.dat");
Error2 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment2 Code\ErrorVsRuntime2.dat");
Error3 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment2 Code\ErrorVsRuntime3.dat");
Error_Ver_RK4 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment2 Code\ErrorVsRuntime_Verlet_RK4.dat");


hold off
%plot(TKE(:,1),TKE(:,2))
%plot(Error1(1:7,3), Error1(1:7,2), "b O")
hold on
%plot(Error1(8:14,3), Error1(8:14,2), "r O")
%plot(Error2(1:5,2), Error2(1:5,3), "b  O")
%plot(Error2(7:11,2), Error2(7:11,3), "r  O")
%plot(Error3(1:12,3), Error3(1:12,2), "b  O")
%plot(Error3(14:17,3), Error3(14:17,2), "r  O")
%plot(Error_Ver_RK4(1:19,1), Error_Ver_RK4(1:19,2), "b O")
%plot(Error_Ver_RK4(21:43,1), Error_Ver_RK4(21:43,2), "r O")
%plot(TU(:,1),TU(:,2))
%plot(TU(:,1)+TKE(:,1),TU(:,2)+TKE(:,2))
plot(TLX(:,1),TLX(:,2))
plot(TLY(:,1),TLY(:,2))
plot(TLZ(:,1),TLZ(:,2))
legend('Total Angular (x-Dir)', 'Total Angular (y-Dir)', 'Total Angular (z-Dir)')
title("Energies")
xlabel('Elapsed Time (s)')
ylabel('Angular Momenta')
ax = gca;
ax.FontSize = 17;