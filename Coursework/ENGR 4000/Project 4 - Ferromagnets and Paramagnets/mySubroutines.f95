module mySubroutines
    integer:: size = 25, bigNum1 = 50000, bigNum2 = 500000
    double precision, parameter:: Mu = 2.74009994D-24, & 
    T_Curie = 1043.2, k = 1.380649D-23 ! k = [J/K]
    double precision:: SumE, SumM, SumE2, SumM2, AvgE, AvgE2, AvgM, AvgM2, E, M, heatCap, susceptibility
    double precision:: J = 0.5 * T_Curie * (k*log(1.0 + sqrt(2.0))) ! For Ferromagnetism
    !double precision:: J = 0 ! For Paramagnetism
    integer, allocatable :: seed(:)
    integer :: randNum = 20

    ! n is the number of neighbors = 4

contains 
! Calculates the initial configuration ----------------------------------
subroutine setInitialConfig(spin)
    implicit none
    integer:: i, j
    double precision:: tmp
    integer, dimension(:, :):: spin

    do i = 1, size
        do j = 1, size
            call random_number(tmp)
            if (tmp .le. 0.5) then
                spin(i, j) = -1
            else
                spin(i,j) = 1
            end if
        end do
    end do

end subroutine

! -----------------------------------------------------
! Does Burn In (AKA gets rid of a lot of bad values)
subroutine burnIn(spin, B, T)
    implicit none
    integer:: ri, rj, n
    integer, dimension(:,:):: spin
    double precision:: tmp, DE, B, T

    open(unit=112, file='BurnInEnergies.dat')

    E = 0.0
    M = 0.0

    do n = 1, bigNum1
        call random_number(tmp)
        ri = floor(tmp*size) + 1
        call random_number(tmp)
        rj = floor(tmp*size) + 1
        
        spin(ri, rj) = -1 * spin(ri, rj)
        DE = -2.0 * J * (spin(mod(ri, size)+1, rj) + spin(ri, (mod(rj, size)+1)) &
         + spin(mod(ri+size-2, size)+1,rj) + spin(ri, (mod(rj+size-2, size)+1))) * &
         spin(ri, rj) - Mu * B * spin(ri, rj)

         if (DE < 0) then
            E = E + DE
            M = M + 2* spin(ri, rj)
         else 
            call random_number(tmp)
            if(tmp < exp(-DE/(k*T))) then
                E = E +DE
                M = M + 2*spin(ri, rj)
            else
                spin(ri, rj) = -spin(ri,rj)
            end if
        end if
            write(112,*) n, E
    end do
    close(112)

end subroutine

! -----------------------------------------------------
! Calculate the actual desired values
subroutine calculate(spin, B, T)

    implicit none
    integer:: ri, rj, n
    integer, dimension(:,:):: spin
    double precision:: tmp, DE, B, T

    do n = 1, bigNum2
        call random_number(tmp)
        ri = floor(tmp*size) + 1
        call random_number(tmp)
        rj = floor(tmp*size) + 1
        
        spin(ri, rj) = -spin(ri, rj)
        DE = -2.0 * J * (spin(mod(ri, size)+1, rj) + spin(ri, (mod(rj, size)+1)) &
         + spin(mod(ri+size-2, size)+1,rj) + spin(ri, (mod(rj+size-2, size)+1))) * &
         spin(ri, rj) - Mu * B * spin(ri, rj)

         if (DE < 0) then
            E = E + DE
            M = M + 2* spin(ri, rj)
         else 
            call random_number(tmp)
            if(tmp < exp(-DE/(k*T))) then
                E = E + DE
                M = M + 2*spin(ri, rj)
            else
                spin(ri, rj) = -spin(ri,rj)
                SumE = SumE + E
                SumE2 = SumE2 + E*E
                SumM = SumM + abs(M)
                SumM2 = SumM2 + M*M
            end if
        end if


    end do

    AvgE = SumE/bigNum2
    AvgE2 = SumE2/bigNum2
    AvgM = SumM/bigNum2
    AvgM2 = SumM2/bigNum2

    heatCap = (1.0/(k*T*T)) * (AvgE2-AvgE*AvgE)
    susceptibility = (AvgM2 - AvgM*AvgM)/(k*T)


end subroutine

end module mySubroutines