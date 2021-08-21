program Assignment_1
    implicit none
    
    integer:: i, Z = 10
    integer, parameter:: numsteps = 10000
    double precision:: r0 = 100.0, tau    ! r0 is the number of bohr radii we are in seperation
    double precision, dimension(0 : numsteps):: r, u, u1p, u2p, f
    integer:: n, l, ans1
    

        ! Constants
    double precision:: hbar = 1.0, me = 1.0, k = 1.0, & 
                       echarge = 1.0, Rydberg = 0.5, sum, E, sumOfError, expectation

write(*,*) "Which method would you like to use? 1) Verlet 2) Euler"
read(*,*) ans1

    do Z = 1, 1   
        write(*,*) "-----------------------Z =", Z, "-----------------------"         
    do n = 1, 4
           do l = 0, n-1
            if (l == n) then
                exit
            end if

!------------------- Initializations -------------------------!
            sum = 0.0
            sumOfError = 0.0
            expectation = 0.0
            E = -Rydberg * (Z**2) / (n**2.0)
            tau = r0 / numsteps

            u(numsteps) = 1.0
            u(numsteps-1) = 1.0
            u1p(numsteps) = 0.0
            r(numsteps) = r0

!------------------------- Opening file ---------------------------!

            !open(unit = 50, file = 'UvsR_10.dat')
            open(unit = 60, file = 'UvsR_Norm_10.dat')
            open(unit = 100, file = 'Uvsr_10.dat')
            open(unit = 200, file = 'Uvsr_20.dat')
            open(unit = 300, file = 'Uvsr_21.dat')
            open(unit = 400, file = 'Uvsr_30.dat')
            open(unit = 500, file = 'Uvsr_31.dat')
            open(unit = 600, file = 'Uvsr_32.dat')
            open(unit = 700, file = 'Uvsr_40.dat')
            open(unit = 800, file = 'Uvsr_41.dat')
            open(unit = 900, file = 'Uvsr_42.dat')
            open(unit = 999, file = 'Uvsr_43.dat')
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


!-------------------- Begin Computation -----------------!

!-------------------Verlet/Euler--------------!    
        if (ans1 == 1) then
            do i = numsteps, 2, -1
                r(i - 1) = r0 - tau*(numsteps - i + 1)    ! Defining the values of r

                u2p(i-1) = (-2.0*me/((hbar)**2.0)) * (E + (z*k*((echarge)**2.0))/(r(i-1)) &
                        - (((hbar)**2.0)*l*(l+1.0))/(2.0*me*(r(i-1)**2.0))) * u(i-1)    ! Defining the values of u2p

                        u(i-2) = 2.0*u(i-1) - u(i) + (tau**2.0)*u2p(i-1)                      ! Defining the values of u
            end do
                
        else if (ans1 == 2) then
            do i = numsteps, 2, -1
                r(i) = r0 - tau*(numsteps - i)    ! Defining the values of r

                u2p(i) = (-2.0*me/((hbar)**2.0)) * (E + (z*k*((echarge)**2.0))/(r(i)) &
                        - (((hbar)**2.0)*l*(l+1.0))/(2.0*me*(r(i)**2.0))) * u(i)    ! Defining the values of u2p
                u1p(i-1) = u1p(i) - tau * u2p(i)
                u(i-1) = u(i) - tau * u1p(i)                  
            end do
        end if



    ! In order to Normalize the function, we need to find the Complex coefficient A
    ! A = sqrt(1 / (Integral of U(r)**2))      
    ! Use Simpson's Rule to solve the Integral


!---------------------- Implimentation of Simpson's Rule ------------!

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

            write(*,*) "The Error values for the n/l combinations are as follows:"

            call errorCalc(u, f, numsteps, tau, sumOfError)  ! Calculating Error of functions
            write(*,*) "n/l = ", n, l, " : ", sumOfError

            call expectationCalc(u, r, numsteps, tau, expectation)
            write(*,*) "Expectation Value = ", expectation
            


        else if (n == 2 .and. l == 0) then
            do i = 0, numsteps
                u(i) = u(i) * (sum ** (-0.5))
                write(200,*) r(i), -u(i)

                f(i) = 2.0**(-0.5) * (1.0 - 0.5*r(i)) * exp(-0.5 * r(i))
                write(2000,*) r(i), f(i)*r(i)
            end do

            call errorCalc(u, f, numsteps, tau, sumOfError)  ! Calculating Error of functions
            write(*,*) "n/l = ", n, l, " : ", sumOfError

            call expectationCalc(u, r, numsteps, tau, expectation)
            write(*,*) "Expectation Value = ", expectation



        else if (n == 2 .and. l == 1) then
            do i = 0, numsteps
                u(i) = u(i) * (sum ** (-0.5))
                write(300,*) r(i), u(i)

                f(i) = 24.0**(-0.5) * r(i) * exp(-0.5 * r(i))
                write(3000,*) r(i), f(i)*r(i)
            end do

            call errorCalc(u, f, numsteps, tau, sumOfError)  ! Calculating Error of functions
            write(*,*) "n/l = ", n, l, " : ", sumOfError
            
            call expectationCalc(u, r, numsteps, tau, expectation)
            write(*,*) "Expectation Value = ", expectation



        else if (n == 3 .and. l == 0) then
            do i = 0, numsteps
                u(i) = u(i) * (sum ** (-0.5))
                write(400,*) r(i), u(i)

                f(i) = (2.0 / (sqrt(27.0))) * (1.0 - (2.0/3.0)*r(i) + (2.0/27.0) * ((r(i))**2.0)) * exp(-r(i)/3.0)
                write(4000,*) r(i), f(i)*r(i)
            end do

            call errorCalc(u, f, numsteps, tau, sumOfError)  ! Calculating Error of functions
            write(*,*) "n/l = ", n, l, " : ", sumOfError

            call expectationCalc(u, r, numsteps, tau, expectation)
            write(*,*) "Expectation Value = ", expectation



        else if (n == 3 .and. l == 1) then
            do i = 0, numsteps
                u(i) = u(i) * (sum ** (-0.5))
                write(500,*) r(i), -u(i)

                f(i) = 8.0/(27.0*(6.0**0.5)) * (1.0-r(i)/6.0) * r(i) * exp(-r(i)/3.0)
                write(5000,*) r(i), f(i)*r(i)
            end do

            call errorCalc(u, f, numsteps, tau, sumOfError)  ! Calculating Error of functions
            write(*,*) "n/l = ", n, l, " : ", sumOfError

            call expectationCalc(u, r, numsteps, tau, expectation)
            write(*,*) "Expectation Value = ", expectation



        else if (n == 3 .and. l == 2) then
            do i = 0, numsteps
                u(i) = u(i) * (sum ** (-0.5))
                write(600,*) r(i), u(i)

                f(i) = 4.0/(81.0*(30.0**0.5)) * (r(i)**2.0) * exp(-r(i)/3.0)
                write(6000,*) r(i), f(i)*r(i)
            end do

            call errorCalc(u, f, numsteps, tau, sumOfError)  ! Calculating Error of functions
            write(*,*) "n/l = ", n, l, " : ", sumOfError

            call expectationCalc(u, r, numsteps, tau, expectation)
            write(*,*) "Expectation Value = ", expectation



        else if (n == 4 .and. l == 0) then
            do i = 0, numsteps
                u(i) = u(i) * (sum ** (-0.5))
                write(700,*) r(i), -u(i)

                f(i) = 0.25 * (1 - 0.75*r(i) + (1.0 / 8.0) * (r(i)**2.0) - (r(i)**3.0)/192.0) * exp(-r(i)/4.0)
                write(7000,*) r(i), f(i)*r(i)
            end do

            call errorCalc(u, f, numsteps, tau, sumOfError)  ! Calculating Error of functions
            write(*,*) "n/l = ", n, l, " : ", sumOfError

            call expectationCalc(u, r, numsteps, tau, expectation)
            write(*,*) "Expectation Value = ", expectation



        else if (n == 4 .and. l == 1) then
            do i = 0, numsteps
                u(i) = u(i) * (sum ** (-0.5))
                write(800,*) r(i), u(i)

                f(i) = sqrt(5.0) / (16.0 * sqrt(3.0)) * (1.0-0.25*r(i) + (r(i)**2.0)/80.0) * r(i) * exp(-r(i)/4.0)
                write(8000,*) r(i), f(i)*r(i)
            end do

            call errorCalc(u, f, numsteps, tau, sumOfError)  ! Calculating Error of functions
            write(*,*) "n/l = ", n, l, " : ", sumOfError

            call expectationCalc(u, r, numsteps, tau, expectation)
            write(*,*) "Expectation Value = ", expectation



        else if (n == 4 .and. l == 2) then
            do i = 0, numsteps
                u(i) = u(i) * (sum ** (-0.5))
                write(900,*) r(i), -u(i)

                f(i) = 1.0 / (64.0 * sqrt(5.0)) * (1.0 - r(i)/12.0) * (r(i)**2.0) * exp(-r(i)/4.0)
                write(9000,*) r(i), f(i)*r(i)
            end do

            call errorCalc(u, f, numsteps, tau, sumOfError)  ! Calculating Error of functions
            write(*,*) "n/l = ", n, l, " : ", sumOfError

            call expectationCalc(u, r, numsteps, tau, expectation)
            write(*,*) "Expectation Value = ", expectation



        else if (n == 4 .and. l == 3) then
            do i = 1, numsteps
                u(i) = u(i) * (sum ** (-0.5))
                write(999,*) r(i), u(i)

                f(i) = 1.0/ (768.0 * sqrt(35.0)) * (r(i)**3.0) * exp(-r(i)/4.0)
                write(10000,*) r(i), f(i)*r(i)
            end do

            call errorCalc(u, f, numsteps, tau, sumOfError)  ! Calculating Error of functions
            write(*,*) "n/l = ", n, l, " : ", sumOfError
            
            call expectationCalc(u, r, numsteps, tau, expectation)
            write(*,*) "Expectation Value = ", expectation



        else 
            do i = 1, numsteps
                u(i) = u(i) * (sum ** (-0.5))
            end do

            call expectationCalc(u, r, numsteps, tau, expectation)
            write(*,*) "Z/n/l = ", Z, n, l, " : ", "Expectation Value = ", expectation
        end if
        f = 0


            
            !--------------------------------------!

            close(50)
            close(60)
            close(100)
            close(200)
            close(300)
            close(400)
            close(500)
            close(600)
            close(700)
            close(800)
            close(900)
            close(999)
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
            close(10001)


    end do 
    l = 0
end do
end do

    print*, "Done!"


end program Assignment_1

subroutine errorCalc(u, f, numsteps, tau, sumOfError)
    implicit none
    double precision:: tau, sumOfError
    integer:: numsteps, i
    double precision, dimension(0 : numsteps):: u, f, error
    sumOfError = 0.0

    error = f - u

    !Integrate (error**2) from 0 to numsteps using simpson's method

    do i = 1, numsteps, 2
        sumOfError = error(i)*error(i) + 4.0*error(i+1)*error(i+1) + error(i+2)*error(i+2) + sumOfError
    end do

    sumOfError = sumOfError * tau / 3.0    ! Part of Simpson's Rule
    

end subroutine

subroutine expectationCalc(u, r, numsteps, tau, expectation)
    implicit none
    integer:: i, numsteps
    double precision, dimension(0:numsteps):: u, r
    double precision:: tau, expectation
    
    !Integrate r * (u(i)**2) from 0 to numsteps using simpson's method

    do i = 1, numsteps, 2
        expectation = (r(i)*u(i)**2) + 4.0*(r(i+1)*u(i+1)**2) + (r(i+2)*u(i+2)**2) + expectation
    end do

    expectation = expectation * tau / 3.0    ! Part of Simpson's Rule

end subroutine