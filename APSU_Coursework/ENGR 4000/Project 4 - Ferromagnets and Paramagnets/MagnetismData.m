clc

EvsT = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment4 Code\EnergyVsTemp.dat");
E2vsT = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment4 Code\Energy2VsTemp.dat");
MvsT = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment4 Code\MagVsTemp.dat");
M2vsT = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment4 Code\Mag2VsTemp.dat");
HCvsT = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment4 Code\HCVsT.dat");
MSvsT = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment4 Code\MSVsT.dat");
EvsB = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment4 Code\EnergyVsB.dat");
E2vsB = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment4 Code\Energy2VsB.dat");
MvsB = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment4 Code\MagVsB.dat");
M2vsB = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment4 Code\Mag2VsB.dat");
HCvsB = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment4 Code\HCVsB.dat");
MSvsB = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment4 Code\MSVsB.dat");
BurnIn = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Assignment4 Code\BurnInEnergies.dat");


hold off
%plot(EvsT(:,1), EvsT(:,2), "r x")
hold on
%plot(E2vsT(:,1), E2vsT(:,2), "r x")
%plot(MvsT(:,1), MvsT(:,2), "r x")
%plot(M2vsT(:,1), M2vsT(:,2), "r x")
%plot(HCvsT(:,1), HCvsT(:,2), "r x")
%plot(MSvsT(:,1), MSvsT(:,2), "r x")
%plot(EvsB(:,1), EvsB(:,2), "r x")
%plot(E2vsB(:,1), E2vsB(:,2), "r x")
%plot(MvsB(:,1), MvsB(:,2), "r x")
%plot(M2vsB(:,1), M2vsB(:,2), "r x")
%plot(HCvsB(:,1), HCvsB(:,2), "r x")
%plot(MSvsB(:,1), MSvsB(:,2), "r x")
%plot(BurnIn(:,1), BurnIn(:,2), "r")
%legend('Energy')
xlabel('External Magnetic Field (H)')
ylabel('Magnetization (H)')
ax = gca;
ax.FontSize = 17;