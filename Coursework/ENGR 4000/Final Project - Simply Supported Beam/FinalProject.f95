program Project

    ! Assuming a 3D beam attached at both ends in a simply supported beam.
    ! Load is evenly distributed
    ! Assuming Weight is negligable
    ! Using Finite Element Analysis to solve for the stress at various points.
    ! Wanted to use Euler's method or RK4 to find a solution to the Bending-Deflection Relation, but was never able to get to it.


    implicit none
    character(len = 5):: number
    double precision, allocatable, dimension(:,:):: stress
    double precision, allocatable, dimension(:):: moment, shear, deflection
    double precision:: loadDist, crackStress, E, fractureToughness, &
    totalLength = 30.0, totalWidth, elmLength, Inertia, crackLength, pi, maxStress
    integer:: numLengthElms, numWidthElms, i, j, neutral, deltaY, load, fileInc

    ! Pre-Initializations
    totalWidth = totalLength / 5.0
    numLengthElms = int(totalLength * 10) + 1
    numWidthElms = int(totalWidth * 10) + 1

    ! Allocations
    allocate(stress(numLengthElms, numWidthElms))
    allocate(moment(numLengthElms), shear(numLengthElms), deflection(numLengthElms))

    open (unit = 107, file = 'break.dat')

    ! Modify the load range to narrow in on the point which it fractures, or to produce various deflection curves.
    do load = 1914000, 1917000, 10
            write(*,*) load - 1000000

        ! Initializations / Initial Conditions
        E = 4700E6     ! Typical Elastic Modulus for Concrete
        fractureToughness = 1E6 ! Roughly 1.0 MPaSqrt(m) is assumed
        pi = 4.0 * Atan(1.0);
        elmLength = totalLength / (numLengthElms-1)
        crackLength = elmLength
        stress = 0
        deflection = numWidthElms / 2
        neutral = numWidthElms / 2
        Inertia = (totalWidth**4) / 12.0
        !load = 5E9 ! In Newtons {N} ! The Load is applied on Element NumLengthElms / 2
        loadDist = dble(load) / totalLength ! Load Distribution
        crackStress = fractureToughness / sqrt(pi* crackLength)
        
        fileInc = load
        write(number,"(I0)") fileInc / 100000
        open(unit = fileInc, file = 'deflectionCurve'//trim(number)//'.dat')


        open (unit = 100, file = 'stress.dat')
        open (unit = 101, file = 'stressMatlab.dat')
        open (unit = 102, file = 'deflectionCurve.dat')
        !open (unit = 103, file = 'region.dat')
        open (unit = 104, file = 'neutral.dat')
        open (unit = 105, file = 'moment.dat')
        open (unit = 106, file = 'shear.dat')

        
        ! Finding the Moments and Shears ----------------------------------------------------------------------


        do i = 1, numLengthElms
            moment(i) = - (loadDist / 2.0) * ((i-1) * elmlength)**2 + & 
            (loadDist * totalLength / 2.0) * ((i-1) * elmlength)
            shear(i) = - loadDist * ((i-1) * elmlength) + loadDist * totalLength / 2.0
        end do

        do i = 1, numLengthElms
            write(105, *) i, moment(i)
            write(106, *) i, shear(i)
        end do


        ! Finding the Stress Matricies -----------------------------------


        do i = 1, numWidthElms
            deltaY = i - neutral - 1
            do j = 1, numLengthElms
                stress(j, i) = - (moment(j)*deltaY) / Inertia
                write(100,*) j, i, stress(j,i)
            end do
        end do

        do i = 1, numWidthElms      
            do j = 1, numLengthElms
                write(101,'(F30.8)', ADVANCE='no') stress(j,i)
            end do
            write(101, *)
        end do


        ! Finding the Deflection Curve ----------------------------------------------


        do i = 1, numLengthElms
            deflection(i) = deflection(i) - (loadDist / (24.0 * E * Inertia))*((i-1) * elmLength) * &
            ((totalLength)**3 - 2.0 * totalLength*((i-1) * elmLength)**2 + ((i-1) * elmLength)**3)
            !write(102,*) i, deflection(i)
            write(fileInc,*) i, deflection(i)
        end do


        ! Making a neutral .dat file ------------------------------------------------


        do i = 1, numLengthElms
            write(104, *) i, neutral
        end do


        ! Determining if the beam fractures ----------------------------------


        ! Assuming Initial crack of length 0.5
        maxStress = 2.0 * stress(numLengthElms/2, 1) * sqrt(crackLength / 0.5)
        write(*,*) maxStress, crackStress
        if (maxStress < crackStress) then
            write(107,*) "Load=", load, "Max Deflection=", deflection(numLengthElms/2), "Not Fractured"
        else
            write(107,*) "Load=", load, "Max Deflection=", deflection(numLengthElms/2), "Fractured!"
        end if


        close(100)
        close(101)
        close(102)
        close(104)
        close(105)
        close(106)
        close(fileInc)


    end do
    close(107)

    deallocate(stress)
    deallocate(shear)
    deallocate(moment)
    deallocate(deflection)

end program Project