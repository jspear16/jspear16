program Assignment3
    use Accelerations
    implicit none
    character(len = 5):: number
    integer:: i, j, time, fileInc, index, numTests = 1000
    double precision, dimension(sizex*sizey,numsteps):: u, v
    double precision, dimension(sizex*sizey,sizex*sizey):: al
    double precision, dimension(sizex,sizey):: cx, cy
    double precision:: period, a, tau

    al = 0.0
    u = 0.0
    v = 0.0
    cx = 0.0
    cy = 0.0

    ! The above "open" commmand opens many files based on the number of times you want to use. It is 
    ! commented out so you do not accidently create many files unintentionally. Uncomment this, 
    ! the write loop, and the close loop to use this feature. 

    ! Open Files --------------------------------------------------------------
    !do i = 1, numTests
    !    fileInc = i * 100
    !    write(number,"(I0)") i
    !    open(unit = fileInc, file = 'test'//trim(number)//'.dat')
    !end do


    open(unit = 101, file = 'final.dat')
    open(unit = 104, file = 'PositionVsTime.dat')

    ! Sets the stiffness of the material
    cx = 2
    cy = 2

    !------------ Initial Conditions ------------------!
            ! Setting a barrier
    do i = 1, sizey
        do j = sizex/2, sizex
            cx(i, j) = 1
            cy(i, j) = 1
        end do 
    end do

    ! Choose which inital condition by commenting the original, and uncommenting the desired.
    ! Standing Wave
    ! Initial Position of the manifold
        do i = 1, sizey
            do j = 1, sizex
                
                ! Basic Standing Wave ---------------------------------
                u((i-1)*sizex + j, 1) = sin((n*PI)/(sizex + 1) * j) * &
                sin((m*PI)/(sizey + 1) * i)

                ! Putting Wave only at one end up ------------------------------
                !u(i, 1) = 10.0 * sin((n*PI)/(sizex + 1) * 1) * &
                !sin((m*PI)/(sizey + 1) * i)

                ! Basic 10 Start -------------------------------
                !u(i, 1) = 10
    
            end do 
        end do

        a = sqrt(cx(1,1))
        period = 2.0*(a*(dble(n)/(sizex+1.0))**2.0 + a * (dble(m)/(sizey+1.0))**2.0)**(-0.5) 
        tau = period / (numsteps/numperiods)

        call pop_al(al, cx, cy)
        call calc_RK4(u, v, al, tau)

        ! Finding Various U's at different timesteps -----------------------------------------
    !do time = 1, numTests
    !        fileInc = time * 100

        !do i = 1, sizey
        !    do j = 1, sizex
        !        write(fileInc, *) time, u((i-1)*sizex + j, time)
        !    end do
        !end do
    !end do

    ! Finding Special timesteps -------------------------------
    do i = 1, sizey
        do j = 1, sizex
            index = dble(numsteps) * 0.9
            write(101, *) numsteps-1, u((i-1)*sizex + j, numsteps-1)
            !write(102, *) numsteps/2, u((i-1)*sizex + j, numsteps/2)    ! 102 and 103 were used for testing purpose.
            !write(103, *) index, u((i-1)*sizex + j, index)              ! They are no longer used in this code.
        end do
    end do

    ! Closes all files from above open statement.
    ! Close Files ------------------------------
    !do i = 1, numTests
    !    fileInc = i * 100
    !    close(fileInc)
    !end do

    ! Writes the position as a funciton of time for a point at the center of the boundary region.
    do i = 1, numsteps
        write(104, *) i, u((3*sizex/4-1)*sizex + sizey/2, i)
    end do


    close(101)
    close(102)
    close(103)
    close(104)

end program Assignment3