program Computational_4
    use mySubroutines
    ! T_Curie = 1043.2 for Iron Found in E&M Book
    ! J is the Coupling Coefficient (0 if )
    ! REIF 10.6, 10.7 to get J equation
    implicit none
    double precision:: B, T
    integer, dimension(:,:), allocatable:: spin
    integer:: tempStep, BStep

    allocate(spin(size,size))
    call random_seed(size = randNum)
    allocate(seed(randNum))
    call random_seed(get=seed)

    spin = 0
    AvgE = 0.0
    AvgE2 = 0.0
    AvgM = 0.0
    AvgM2 = 0.0

    open(unit = 100, file = 'EnergyVsTemp.dat')
    open(unit = 101, file = 'Energy2VsTemp.dat')
    open(unit = 102, file = 'MagVsTemp.dat')
    open(unit = 103, file = 'Mag2VsTemp.dat')
    open(unit = 109, file = 'HCVsT.dat')
    open(unit = 110, file = 'MSVsT.dat')


    ! Changing T ----------------------------------------------

    do tempStep = 100, 2000, 1
        BStep = 10
        T = dble(tempStep)
        B = dble(BStep)
        call setInitialConfig(spin(:,:)) 
        call burnIn(spin(:,:), B, T)
        call calculate(spin, B, T)
        ! ^^^ Calculates the AvgE, AvgE2, AvgM, and AvgM2 for each iteration

        write(100,*) T, AvgE
        write(101,*) T, AvgE2
        write(102,*) T, AvgM
        write(103,*) T, AvgM2
        write(109,*) T, heatCap
        write(110,*) T, susceptibility

        SumE = 0.0
        SumE2 = 0.0
        SumM = 0.0
        SumM2 = 0.0
        print*, B, T
    end do

    ! Changing B ----------------------------------------------

    open(unit = 104, file = 'EnergyVsB.dat')
    open(unit = 105, file = 'Energy2VsB.dat')
    open(unit = 106, file = 'MagVsB.dat')
    open(unit = 107, file = 'Mag2VsB.dat')
    open(unit = 119, file = 'HCVsB.dat')
    open(unit = 120, file = 'MSVsB.dat')

    do BStep = -200, 200, 1
        tempStep = 600
        T = dble(tempStep)
        B = dble(BStep) / 100.0 ! Makes the change in B = 0.2
        call setInitialConfig(spin(:,:)) 
        call burnIn(spin(:,:), B, T)
        call calculate(spin, B, T)
        ! ^^^ Calculates the AvgE, AvgE2, AvgM, and AvgM2 for each iteration


        write(104,*) B, AvgE
        write(105,*) B, AvgE2
        write(106,*) B, AvgM
        write(107,*) B, AvgM2
        write(119,*) B, heatCap
        write(120,*) B, susceptibility

        SumE = 0.0
        SumE2 = 0.0
        SumM = 0.0
        SumM2 = 0.0
        print*, B, T
    end do

    deallocate(spin)

    close(100)
    close(101)
    close(102)
    close(103)
    close(104)
    close(105)
    close(106)
    close(107)
    close(109)
    close(119)
    close(110)
    close(120)

end program Computational_4