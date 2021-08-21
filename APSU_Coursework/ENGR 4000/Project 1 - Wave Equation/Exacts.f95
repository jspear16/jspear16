program exacts
    implicit none

    integer:: i, Z = 1
    integer, parameter:: numsteps = 100000
    double precision:: r0 = 100.0, tau    ! r0 is the number of bohr radii we are in seperation
    double precision, dimension(0 : numsteps):: r, u, u1p, f
    integer:: n, l

        ! Constants
    double precision::Rydberg = 0.5, sum, E, sumOfError
    do n = 1, 4
           do l = 0, 3
            if (l == n) then
                exit
            end if

!------------------- Initializations -------------------------!
            sum = 0.0
            sumOfError = 0.0
            E = -Rydberg * (Z**2) / (n**2.0)
            tau = r0 / numsteps

            u(numsteps) = 1.0
            u(numsteps-1) = 1.0
            u1p(numsteps) = 0.0
            r(numsteps) = r0

            !------------------------- Opening file ---------------------------!

            open(unit = 1000, file = 'Exact_10.dat')
            open(unit = 2000, file = 'Exact_20.dat')
            open(unit = 3000, file = 'Exact_21.dat')
            open(unit = 4000, file = 'Exact_30.dat')
            open(unit = 5000, file = 'Exact_31.dat')
            open(unit = 6000, file = 'Exact_32.dat')
            open(unit = 7000, file = 'Exact_40.dat')
            open(unit = 8000, file = 'Exact_41.dat')
            open(unit = 9000, file = 'Exact_42.dat')
            open(unit = 10000, file = 'Exact_43.dat')
            open(unit = 10001, file = 'U2P_43.dat')

            do i = numsteps, 2, -1
                r(i - 1) = r0 - tau*(numsteps - i + 1)  
            end do

            !------------------------ Exact Solutions ---------------------------!

            do i = 1, numsteps, 2
                sum = u(i)*u(i) + 4.0*u(i+1)*u(i+1) + u(i+2)*u(i+2) + sum
            end do

            sum = sum * tau / 3.0    ! Part of Simpson's Rule



            if (n == 1 .and. l == 0) then
            do i = 0, numsteps
                u(i) = u(i) * (sum ** (-0.5))
                write(100,*) r(i), u(i)

                f(i) = 2.0*exp(-r(i))
                write(1000,*) r(i), f(i)*r(i)
            end do

            !write(*,*) "The Error values for the n/l combinations are as follows:"

            
        else if (n == 2 .and. l == 0) then
            do i = 0, numsteps
                u(i) = u(i) * (sum ** (-0.5))
                write(200,*) r(i), -u(i)

                f(i) = 2.0**(-0.5) * (1.0 - 0.5*r(i)) * exp(-0.5 * r(i))
                write(2000,*) r(i), f(i)*r(i)
            end do



        else if (n == 2 .and. l == 1) then
            do i = 0, numsteps
                u(i) = u(i) * (sum ** (-0.5))
                write(300,*) r(i), u(i)

                f(i) = 24.0**(-0.5) * r(i) * exp(-0.5 * r(i))
                write(3000,*) r(i), f(i)*r(i)
            end do
            


        else if (n == 3 .and. l == 0) then
            do i = 0, numsteps
                u(i) = u(i) * (sum ** (-0.5))
                write(400,*) r(i), u(i)

                f(i) = (2.0 / (sqrt(27.0))) * (1.0 - (2.0/3.0)*r(i) + (2.0/27.0) * ((r(i))**2.0)) * exp(-r(i)/3.0)
                write(4000,*) r(i), f(i)*r(i)
            end do



        else if (n == 3 .and. l == 1) then
            do i = 0, numsteps
                u(i) = u(i) * (sum ** (-0.5))
                write(500,*) r(i), -u(i)

                f(i) = 8.0/(27.0*(6.0**0.5)) * (1.0-r(i)/6.0) * r(i) * exp(-r(i)/3.0)
                write(5000,*) r(i), f(i)*r(i)
            end do



        else if (n == 3 .and. l == 2) then
            do i = 0, numsteps
                u(i) = u(i) * (sum ** (-0.5))
                write(600,*) r(i), u(i)

                f(i) = 4.0/(81.0*(30.0**0.5)) * (r(i)**2.0) * exp(-r(i)/3.0)
                write(6000,*) r(i), f(i)*r(i)
            end do



        else if (n == 4 .and. l == 0) then
            do i = 0, numsteps
                u(i) = u(i) * (sum ** (-0.5))
                write(700,*) r(i), -u(i)

                f(i) = 0.25 * (1 - 0.75*r(i) + (1.0 / 8.0) * (r(i)**2.0) - (r(i)**3.0)/192.0) * exp(-r(i)/4.0)
                write(7000,*) r(i), f(i)*r(i)
            end do



        else if (n == 4 .and. l == 1) then
            do i = 0, numsteps
                u(i) = u(i) * (sum ** (-0.5))
                write(800,*) r(i), u(i)

                f(i) = sqrt(5.0) / (16.0 * sqrt(3.0)) * (1.0-0.25*r(i) + (r(i)**2.0)/80.0) * r(i) * exp(-r(i)/4.0)
                write(8000,*) r(i), f(i)*r(i)
            end do



        else if (n == 4 .and. l == 2) then
            do i = 0, numsteps
                u(i) = u(i) * (sum ** (-0.5))
                write(900,*) r(i), -u(i)

                f(i) = 1.0 / (64.0 * sqrt(5.0)) * (1.0 - r(i)/12.0) * (r(i)**2.0) * exp(-r(i)/4.0)
                write(9000,*) r(i), f(i)*r(i)
            end do



        else if (n == 4 .and. l == 3) then
            do i = 1, numsteps
                u(i) = u(i) * (sum ** (-0.5))
                write(999,*) r(i), u(i)

                f(i) = 1.0/ (768.0 * sqrt(35.0)) * (r(i)**3.0) * exp(-r(i)/4.0)
                write(10000,*) r(i), f(i)*r(i)
            end do

        end if
        f = 0


        close(1000)
        close(2000)
        close(3000)
        close(4000)
        close(5000)
        close(6000)
        close(7000)
        close(8000)
        close(9000)
        close(10000)

        end do
    end do

end program exacts