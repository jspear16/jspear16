program Computational2
    use Gravity
    implicit none
    integer::  bodystep, timestep, ans
    character(len = 40):: name, ID
    double precision, dimension(0:2):: endPos
    double precision, dimension(0:numbodies-1):: m
    !double precision, dimension(0:numbodies-1,0:numsteps-1) :: x, y, z, vx, &
    !vy, vz, ax, ay, az, Lx, Ly, Lz, KE
    double precision, dimension(:,:), allocatable:: x, y, z, vx, &
    vy, vz, ax, ay, az, Lx, Ly, Lz, KE
    double precision:: TU, TKE, TLX, TLY, TLZ, startTime, stopTime, &
    AvgError
    

    AvgError = 0.0

    allocate(x(0:numbodies-1,0:numsteps-1))
    allocate(y(0:numbodies-1,0:numsteps-1))
    allocate(z(0:numbodies-1,0:numsteps-1))
    allocate(vx(0:numbodies-1,0:numsteps-1))
    allocate(vy(0:numbodies-1,0:numsteps-1))
    allocate(vz(0:numbodies-1,0:numsteps-1))
    allocate(ax(0:numbodies-1,0:numsteps-1))
    allocate(ay(0:numbodies-1,0:numsteps-1))
    allocate(az(0:numbodies-1,0:numsteps-1))
    allocate(Lx(0:numbodies-1,0:numsteps-1))
    allocate(Ly(0:numbodies-1,0:numsteps-1))
    allocate(Lz(0:numbodies-1,0:numsteps-1))
    allocate(KE(0:numbodies-1,0:numsteps-1))



    open(unit = 101, file = 'Sol.dat')
    open(unit = 102, file = 'Mercury.dat')
    open(unit = 103, file = 'Venus.dat')
    open(unit = 104, file = 'Earth.dat')
    open(unit = 105, file = 'Mars.dat')
    open(unit = 106, file = 'Jupiter.dat')
    open(unit = 107, file = 'Saturn.dat')
    open(unit = 108, file = 'Uranus.dat')
    open(unit = 109, file = 'Neptune.dat')
    open(unit = 110, file = 'Pluto.dat')
    open(unit = 111, file = 'Moon.dat')
    open(unit = 200, file = 'TLX.dat')
    open(unit = 201, file = 'TLY.dat')
    open(unit = 202, file = 'TLZ.dat')
    open(unit = 203, file = 'TKE.dat')
    open(unit = 204, file = 'TU.dat')
    open(unit = 300, file = 'Error.dat')
    open(unit = 400, file = 'Outputs.dat')


    open(unit = 100, file = '1967_08_01.txt')
    do bodystep = 0, numbodies-1
        read(100, *) name, ID, m(bodystep), x(bodystep, 0), y(bodystep, 0), & 
        z(bodystep, 0), vx(bodystep, 0), vy(bodystep, 0), vz(bodystep, 0)
    end do
    close(100)


    write(*,*) "Would you like to use Verlet, or RK4? (1 = Verlet, 2 = RK4)"
    read(*,*) ans


    if (ans == 1) then
        write(*,*) "You chose Verlet"

        call cpu_time(startTime)

        call calc_verlet(x(:,:), y(:,:), z(:,:), vx(:,:), vy(:,:), vz(:,:), &
        ax(:,:), ay(:,:), az(:,:), m(:))

        call cpu_time(stopTime)

    else
        write(*,*) "You chose RK4"

        call cpu_time(startTime)

        call calc_RK4(x(:,:), y(:,:), z(:,:), vx(:,:), vy(:,:), vz(:,:), m(:))

        call cpu_time(stopTime)

    end if
    
    write(*,*) "Time Info:"
    write(*,*) ans, stopTime - startTime

    do timestep = 1, numsteps-2, 5
        call calc(m(:), x(:, timestep), y(:, timestep), z(:, timestep), &
        vx(:, timestep), vy(:, timestep), vz(:, timestep), Lx(:, timestep), &
        Ly(:, timestep), Lz(:, timestep), TU, KE(:, timestep), TKE, TLX, TLY, TLZ)
        write(200,*) tau*timestep, TLX
        write(201,*) tau*timestep, TLY
        write(202,*) tau*timestep, TLZ
        write(203,*) tau*timestep, TKE
        write(204,*) tau*timestep, TU
    end do

    do timestep = 1, numsteps-2, 1
        write(101,*) x(0,timestep), y(0,timestep), z(0,timestep)
        write(102,*) x(1,timestep), y(1,timestep), z(1,timestep)
        write(103,*) x(2,timestep), y(2,timestep), z(2,timestep)
        write(104,*) x(3,timestep), y(3,timestep), z(3,timestep)
        write(105,*) x(4,timestep), y(4,timestep), z(4,timestep)
        write(106,*) x(5,timestep), y(5,timestep), z(5,timestep)
        write(107,*) x(6,timestep), y(6,timestep), z(6,timestep)
        write(108,*) x(7,timestep), y(7,timestep), z(7,timestep)
        write(109,*) x(8,timestep), y(8,timestep), z(8,timestep)
        write(110,*) x(9,timestep), y(9,timestep), z(9,timestep)
        write(111,*) x(10,timestep), y(10,timestep), z(10,timestep)
    end do

    open(unit = 1000, file = '1986-01-24.txt')
    do bodystep = 0, numbodies-1
        read(1000, *) name, ID, m(bodystep), endpos(0), endpos(1), endpos(2)
        
        write(300, *) name
        write(300, *) abs(x(bodystep, numsteps-2) - endpos(0)), abs(y(bodystep, numsteps-2) &
        - endpos(1)), abs(z(bodystep, numsteps-2) - endpos(2))

        AvgError = AvgError + (abs(x(bodystep, numsteps-2) - endpos(0)) + abs(y(bodystep, numsteps-2) &
        - endpos(1)) + abs(z(bodystep, numsteps-2) - endpos(2)))/3.0

        write(400,*) name, ID, x(bodystep, numsteps-2), y(bodystep, numsteps-2), z(bodystep, numsteps-2)

    end do
    close(1000)


    write(*,*) "Error Info:"
    write(*, *) numsteps, seconds/(3600*24), ans, AvgError

    deallocate(x)
    deallocate(y)
    deallocate(z)
    deallocate(vx)
    deallocate(vy)
    deallocate(vz)
    deallocate(ax)
    deallocate(ay)
    deallocate(az)
    deallocate(Lx)
    deallocate(Ly)
    deallocate(Lz)
    deallocate(KE)


    !Calculate Error

    close(101)
    close(102)
    close(103)
    close(104)
    close(105)
    close(106)
    close(107)
    close(109)
    close(110)
    close(111)
    close(112)
    close(200)
    close(201)
    close(202)
    close(203)
    close(204)
    close(300)
    close(400)
    write(*,*) ""
    write(*,*) "DONE!"
    

end program Computational2

