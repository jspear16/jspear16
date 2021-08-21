module Gravity
    implicit none 
    double precision, parameter:: G = 6.674D-20
    integer*8, parameter:: numsteps = 40000, numbodies = 249, seconds = 316500000_8
    double precision:: tau = (seconds * 1.0) / (numsteps * 1.0)

    ! My Complier does:
    ! Promots Integer to Integer*8, change this!
    !  

    contains
    subroutine calc_accel(x, y, z, ax, ay, az, m)
        implicit none
        integer:: i, j
        double precision, dimension(0:):: x, y, z, ax, ay, az, m
        double precision:: dx, dy, dz, rmag
         dx = 0.0
         dy = 0.0
         dz = 0.0
         rmag = 0.0
    
         do i = 0, numbodies-1  ! Initializing the Acceleration Terms to 0
            ax(i) = 0.0
            ay(i) = 0.0
            az(i) = 0.0
         end do
         
         do i = 0, numbodies-1
            do j = 0, i - 1
                dx = x(j) - x(i)
                dy = y(j) - y(i)
                dz = z(j) - z(i)

                rmag = sqrt((dx**2) + (dy**2) + (dz**2))
                ax(j) = (-G * m(i) * dx / (rmag**3)) + ax(j) 
                ay(j) = (-G * m(i) * dy / (rmag**3)) + ay(j)
                az(j) = (-G * m(i) * dz / (rmag**3)) + az(j)

                ax(i) = (G * m(j) * dx / (rmag**3)) + ax(i)
                ay(i) = (G * m(j) * dy / (rmag**3)) + ay(i)
                az(i) = (G * m(j) * dz / (rmag**3)) + az(i)

            end do
         end do
    
    end subroutine calc_accel

    !-----------------------------------------------------------------------------------------------------------


    subroutine calc_RK4(x, y, z, vx, vy, vz, m)
        implicit none
        integer:: timestep
        double precision, dimension(0:, 0:):: x, y, z, &
        vx, vy, vz
        double precision, dimension(0:numbodies-1):: m, v1x, v1y, &
        v1z, v2x, v2y, v2z, v3x, v3y, v3z, v4x, v4y, v4z, a1x, a1y, a1z, &
        a2x, a2y, a2z, a3x, a3y, a3z, a4x, a4y, a4z


        do timestep = 0, numsteps-2
            if (mod(timestep, 10000) == 0) then
                write(*,*) "Test number ", timestep
            end if

            call calc_accel(x(:, timestep), y(:, timestep), z(:, timestep), a1x(:), a1y(:), a1z(:), m(:))
            !--------^^-------- Finding K1 --------^^--------!


                v1x(:) = vx(:, timestep)
                v1y(:) = vy(:, timestep)
                v1z(:) = vz(:, timestep)


                x(:, timestep+1) = x(:, timestep) + tau* v1x(:)/2.0
                y(:, timestep+1) = y(:, timestep) + tau* v1y(:)/2.0
                z(:, timestep+1) = z(:, timestep) + tau* v1z(:)/2.0

                vx(:, timestep+1) = vx(:, timestep) + tau*a1x(:)/2.0
                vy(:, timestep+1) = vy(:, timestep) + tau*a1y(:)/2.0
                vz(:, timestep+1) = vz(:, timestep) + tau*a1z(:)/2.0

            call calc_accel(x(:, timestep+1), y(:, timestep+1), z(:, timestep+1), a2x(:), a2y(:), a2z(:), m(:))
            !-------^^--------- Finding K2 -------^^---------!

                v2x(:) = vx(:, timestep+1)
                v2y(:) = vy(:, timestep+1)
                v2z(:) = vz(:, timestep+1)


                x(:, timestep+1) = x(:, timestep) + tau* v2x(:)/2.0
                y(:, timestep+1) = y(:, timestep) + tau* v2y(:)/2.0
                z(:, timestep+1) = z(:, timestep) + tau* v2z(:)/2.0

                vx(:, timestep+1) = vx(:, timestep) + tau* a2x(:)/2.0
                vy(:, timestep+1) = vy(:, timestep) + tau* a2y(:)/2.0
                vz(:, timestep+1) = vz(:, timestep) + tau* a2z(:)/2.0

            call calc_accel(x(:, timestep+1), y(:, timestep+1), z(:, timestep+1), a3x(:), a3y(:), a3z(:), m(:))
            !-------^^--------- Finding K3 ---------^^-------!

                v3x(:) = vx(:, timestep+1)
                v3y(:) = vy(:, timestep+1)
                v3z(:) = vz(:, timestep+1)


                x(:, timestep+1) = x(:, timestep) + tau* v3x(:)
                y(:, timestep+1) = y(:, timestep) + tau* v3y(:)
                z(:, timestep+1) = z(:, timestep) + tau* v3z(:)

                vx(:, timestep+1) = vx(:, timestep) + tau* a3x(:)
                vy(:, timestep+1) = vy(:, timestep) + tau* a3y(:)
                vz(:, timestep+1) = vz(:, timestep) + tau* a3z(:)

            call calc_accel(x(:, timestep+1), y(:, timestep+1), z(:, timestep+1), a4x(:), a4y(:), a4z(:), m(:))
            !------^^---------- Finding K4 -------^^---------!

                v4x(:) = vx(:, timestep+1)
                v4y(:) = vy(:, timestep+1)
                v4z(:) = vz(:, timestep+1)


                x(:, timestep+1) = x(:, timestep) + (tau/6.0) * (v1x(:) + &
                            2.0*v2x(:) + 2.0*v3x(:) + v4x(:))
                y(:, timestep+1) = y(:, timestep) + (tau/6.0) * (v1y(:) + &
                            2.0*v2y(:) + 2.0*v3y(:) + v4y(:))
                z(:, timestep+1) = z(:, timestep) + (tau/6.0) * (v1z(:) + &
                            2.0*v2z(:) + 2.0*v3z(:) + v4z(:))

                vx(:, timestep+1) = vx(:, timestep) + (tau/6.0) * (a1x(:) + &
                            2.0*a2x(:) + 2.0*a3x(:) + a4x(:))
                vy(:, timestep+1) = vy(:, timestep) + (tau/6.0) * (a1y(:) + &
                            2.0*a2y(:) + 2.0*a3y(:) + a4y(:))
                vz(:, timestep+1) = vz(:, timestep) + (tau/6.0) * (a1z(:) + &
                            2.0*a2z(:) + 2.0*a3z(:) + a4z(:))

        end do

    end subroutine calc_RK4

    !-----------------------------------------------------------------------------------------------------------

    subroutine calc_Euler(x, y, z, vx, vy, vz)
        implicit none
        double precision, dimension(0:, 0:):: x, y, z, &
        vx, vy, vz



        x(:, 1) = x(:, 0) + tau * vx(:, 0)
        y(:, 1) = y(:, 0) + tau * vy(:, 0)
        z(:, 1) = z(:, 0) + tau * vz(:, 0)

    end subroutine calc_Euler
    !-----------------------------------------------------------------------------------------------------------


    subroutine calc_verlet(x, y, z, vx, vy, vz, ax, ay, az, m)
        implicit none
        integer:: timestep
        double precision, dimension(0:, 0:):: x, y, z, &
        vx, vy, vz, ax, ay, az
        double precision, dimension(0:):: m


        call calc_Euler(x(:,0:1), y(:,0:1), z(:,0:1), vx(:,0:1), vy(:,0:1), vz(:,0:1))

        do timestep = 1, numsteps-2
            if (mod(timestep, 10000) == 0) then
                write(*,*) "Test number ", timestep
            end if

            call calc_accel(x(:, timestep), y(:, timestep), z(:, timestep), &
            ax(:, timestep), ay(:, timestep), az(:, timestep), m(:))

            x(:, timestep+1) = 2*x(:, timestep) - x(:, timestep-1) + (tau**2)*ax(:, timestep-1)
            y(:, timestep+1) = 2*y(:, timestep) - y(:, timestep-1) + (tau**2)*ay(:, timestep-1)
            z(:, timestep+1) = 2*z(:, timestep) - z(:, timestep-1) + (tau**2)*az(:, timestep-1)

            vx(:, timestep+1) = (x(:, timestep+1) - x(:, timestep)) / tau
            vy(:, timestep+1) = (y(:, timestep+1) - y(:, timestep)) / tau
            vz(:, timestep+1) = (z(:, timestep+1) - z(:, timestep)) / tau
        end do

    end subroutine calc_verlet

    !-----------------------------------------------------------------------------------------------------------


    subroutine calc(m, x, y, z, vx, vy, vz, & 
    Lx, Ly, Lz, TU, KE, TKE, TLX, TLY, TLZ)
        implicit none
        integer:: body1, body2
        double precision, dimension(0:)::m, x, y, z, &
        vx, vy, vz, Lx, Ly, LZ, KE
        double precision:: TU, TKE, TLX, TLY, TLZ, r
        TLx = 0.0
        TLy = 0.0
        TLz = 0.0
        TKE = 0.0
        TU = 0.0

        do body1 = 0, numbodies-1
            Lx(body1) = m(body1) * (y(body1)*vz(body1) - z(body1)*vy(body1))
            Ly(body1) = m(body1) * (z(body1)*vx(body1) - x(body1)*vz(body1))
            Lz(body1) = m(body1) * (x(body1)*vy(body1) - y(body1)*vx(body1))
            TLX = TLX +Lx(body1)
            TLY = TLY +Ly(body1)
            TLZ = TLZ +Lz(body1)

            KE(body1) = 0.5*m(body1)*(vx(body1)**2 + vy(body1)**2 + vz(body1)**2)
            TKE = TKE + KE(body1)

            do body2 = body1+1, numbodies
                r = ((x(body2)-x(body1))**2 + (y(body2)-y(body1))**2 + (z(body2)-z(body1))**2)
                TU = TU + ((-G * m(body1) * m(body2)) / r**0.5)
            end do
        end do

    end subroutine

end module Gravity