clc 

Stress = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Final Project\stress.dat");
Stress2 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Final Project\stressMatlab.dat");
Region = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Final Project\region.dat");
Deflection = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Final Project\deflectionCurve.dat");
Neutral = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Final Project\neutral.dat");
Shear = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Final Project\shear.dat");
Moment = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Final Project\moment.dat");


Deflection10 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Final Project\deflectionCurve10.dat");
Deflection20 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Final Project\deflectionCurve20.dat");
Deflection30 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Final Project\deflectionCurve30.dat");
Deflection35 = importdata("C:\Users\Spear\OneDrive\Desktop\Computational\Final Project\deflectionCurve35.dat");


% Plotting -----------------------

hold off
%surf(Stress2)
%plot3(Stress(:,1), Stress(:,2), Stress(:,3))
%plot3([0 : 300], Neutral(:, 2), [1000000000 : 1000000300], 'r');
plot(Neutral(:,1), Neutral(:,2), 'k', 'LineWidth', 1)
hold on
plot(Deflection10(:,1), Deflection10(:,2), 'r', 'LineWidth', 1)
plot(Deflection20(:,1), Deflection20(:,2), 'b', 'LineWidth', 1)
plot(Deflection30(:,1), Deflection30(:,2), 'g', 'LineWidth', 1)
plot(Deflection35(:,1), Deflection35(:,2), 'm', 'LineWidth', 1)
%surf(Region,'FaceAlpha',0.5)
%plot3([0 : 300], Deflection1(:, 2), [1000000000 : 1000000300], 'LineWidth', 1.5);
%plot3([0 : 300], Deflection5(:, 2), [1000000000 : 1000000300], 'LineWidth', 1.5);
%plot3([0 : 300], Deflection10(:, 2), [1000000000 : 1000000300], 'LineWidth', 1.5);
%plot(Shear(:,1), Shear(:,2), 'r', 'LineWidth', 2)
%x = [0 300]
%y = [0 0]
%plot(x(:), y(:), 'k', 'LineWidth', 1)



% Plot Settings --------------------

shading interp
xlabel("Length (dm)")
ylabel("Deflection (m)")
zlabel("Stress (Pa)")
ax = gca;
ax.FontSize = 17;
% Settings for L = 30
xlim([1, 301])
%ylim([-45, 105])